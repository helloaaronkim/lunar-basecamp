public with sharing class LunarExpeditionDashboardController {
    public class DashboardResponse {
        @AuraEnabled public List<ExpeditionCard> expeditions;
        @AuraEnabled public List<MonthlyPoint> bookingsByMonth;
        @AuraEnabled public List<SitePoint> bookingsByLandingSite;
    }

    public class ExpeditionCard {
        @AuraEnabled public Id id;
        @AuraEnabled public String expeditionName;
        @AuraEnabled public String explorerName;
        @AuraEnabled public String explorerInitials;
        @AuraEnabled public Date launchDate;
        @AuraEnabled public String landingSite;
        @AuraEnabled public String complianceStatus;
        @AuraEnabled public Decimal totalGearItems;
        @AuraEnabled public Decimal latitude;
        @AuraEnabled public Decimal longitude;
    }

    public class MonthlyPoint {
        @AuraEnabled public String label;
        @AuraEnabled public Integer value;
    }

    public class SitePoint {
        @AuraEnabled public String label;
        @AuraEnabled public Integer value;
    }

    private class Coordinate {
        Decimal latitude;
        Decimal longitude;

        Coordinate(Decimal latitude, Decimal longitude) {
            this.latitude = latitude;
            this.longitude = longitude;
        }
    }

    @AuraEnabled(cacheable=true)
    public static DashboardResponse getDashboardData() {
        DashboardResponse response = new DashboardResponse();
        response.expeditions = new List<ExpeditionCard>();
        response.bookingsByMonth = new List<MonthlyPoint>();
        response.bookingsByLandingSite = new List<SitePoint>();

        List<Expedition_Booking__c> expeditions = [
            SELECT Id, Expedition_Name__c, Explorer__r.Full_Name__c, Launch_Date__c, Landing_Site__c, Compliance_Status__c
            FROM Expedition_Booking__c
            WHERE Status__c IN ('Confirmed', 'In Progress')
            ORDER BY Launch_Date__c ASC
        ];

        Set<Id> expeditionIds = new Set<Id>();
        for (Expedition_Booking__c expedition : expeditions) {
            expeditionIds.add(expedition.Id);
        }

        Map<Id, Decimal> gearTotalsByExpedition = new Map<Id, Decimal>();
        if (!expeditionIds.isEmpty()) {
            for (AggregateResult result : [
                SELECT Expedition_Booking__c expeditionId, SUM(Quantity__c) totalQuantity
                FROM Expedition_Gear__c
                WHERE Expedition_Booking__c IN :expeditionIds
                GROUP BY Expedition_Booking__c
            ]) {
                gearTotalsByExpedition.put(
                    (Id)result.get('expeditionId'),
                    (Decimal)result.get('totalQuantity')
                );
            }
        }

        Map<String, Coordinate> coordinatesBySite = new Map<String, Coordinate>{
            'Tycho Crater' => new Coordinate(-43.37, -11.36),
            'Shackleton Rim' => new Coordinate(-89.90, 0.00),
            'Hadley Rille' => new Coordinate(26.13, 3.63),
            'Mare Tranquillitatis' => new Coordinate(8.50, 31.40),
            'Aristarchus Plateau' => new Coordinate(25.30, -47.40)
        };

        for (Expedition_Booking__c expedition : expeditions) {
            ExpeditionCard card = new ExpeditionCard();
            card.id = expedition.Id;
            card.expeditionName = expedition.Expedition_Name__c;
            card.explorerName = expedition.Explorer__r != null ? expedition.Explorer__r.Full_Name__c : 'Unassigned Explorer';
            card.explorerInitials = getInitials(card.explorerName);
            card.launchDate = expedition.Launch_Date__c;
            card.landingSite = expedition.Landing_Site__c;
            card.complianceStatus = String.isBlank(expedition.Compliance_Status__c) ? 'Pending' : expedition.Compliance_Status__c;
            card.totalGearItems = gearTotalsByExpedition.containsKey(expedition.Id) ? gearTotalsByExpedition.get(expedition.Id) : 0;

            Coordinate coordinate = coordinatesBySite.get(expedition.Landing_Site__c);
            card.latitude = coordinate != null ? coordinate.latitude : 0;
            card.longitude = coordinate != null ? coordinate.longitude : 0;

            response.expeditions.add(card);
        }

        for (AggregateResult result : [
            SELECT CALENDAR_YEAR(Launch_Date__c) launchYear, CALENDAR_MONTH(Launch_Date__c) launchMonth, COUNT(Id) bookingCount
            FROM Expedition_Booking__c
            WHERE Launch_Date__c != NULL
            GROUP BY CALENDAR_YEAR(Launch_Date__c), CALENDAR_MONTH(Launch_Date__c)
            ORDER BY CALENDAR_YEAR(Launch_Date__c), CALENDAR_MONTH(Launch_Date__c)
        ]) {
            MonthlyPoint point = new MonthlyPoint();
            Integer yearValue = (Integer)result.get('launchYear');
            Integer monthValue = (Integer)result.get('launchMonth');
            point.label = monthName(monthValue) + ' ' + String.valueOf(yearValue);
            point.value = (Integer)result.get('bookingCount');
            response.bookingsByMonth.add(point);
        }

        for (AggregateResult result : [
            SELECT Landing_Site__c landingSite, COUNT(Id) bookingCount
            FROM Expedition_Booking__c
            WHERE Landing_Site__c != NULL
            GROUP BY Landing_Site__c
            ORDER BY COUNT(Id) DESC
        ]) {
            SitePoint point = new SitePoint();
            point.label = (String)result.get('landingSite');
            point.value = (Integer)result.get('bookingCount');
            response.bookingsByLandingSite.add(point);
        }

        return response;
    }

    private static String getInitials(String fullName) {
        if (String.isBlank(fullName)) {
            return 'NA';
        }

        List<String> parts = fullName.trim().split('\\s+');
        if (parts.size() == 1) {
            return parts[0].left(2).toUpperCase();
        }
        return (parts[0].left(1) + parts[parts.size() - 1].left(1)).toUpperCase();
    }

    private static String monthName(Integer monthNumber) {
        List<String> names = new List<String>{
            'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
            'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
        };
        if (monthNumber == null || monthNumber < 1 || monthNumber > 12) {
            return 'Unknown';
        }
        return names[monthNumber - 1];
    }
}
