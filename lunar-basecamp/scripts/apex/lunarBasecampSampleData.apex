List<Lunar_Explorer__c> explorers = new List<Lunar_Explorer__c>{
    new Lunar_Explorer__c(
        Full_Name__c = 'Sarah Chen',
        Email__c = 'sarah.chen@lunarbasecampoutfitters.com',
        EVA_Hours__c = 82,
        Certification_Level__c = 'Novice Crater Walker',
        Medical_Clearance_Date__c = Date.newInstance(2026, 3, 18),
        Emergency_Contact__c = 'Daniel Chen (+1-415-555-0121)'
    ),
    new Lunar_Explorer__c(
        Full_Name__c = 'Marcus Rodriguez',
        Email__c = 'marcus.rodriguez@lunarbasecampoutfitters.com',
        EVA_Hours__c = 156,
        Certification_Level__c = 'Advanced Lava Tube Explorer',
        Medical_Clearance_Date__c = Date.newInstance(2026, 1, 27),
        Emergency_Contact__c = 'Elena Rodriguez (+1-210-555-0188)'
    ),
    new Lunar_Explorer__c(
        Full_Name__c = 'Yuki Tanaka',
        Email__c = 'yuki.tanaka@lunarbasecampoutfitters.com',
        EVA_Hours__c = 274,
        Certification_Level__c = 'Advanced Lava Tube Explorer',
        Medical_Clearance_Date__c = Date.newInstance(2025, 12, 9),
        Emergency_Contact__c = 'Aiko Tanaka (+81-90-5555-3001)'
    ),
    new Lunar_Explorer__c(
        Full_Name__c = 'Dmitri Volkov',
        Email__c = 'dmitri.volkov@lunarbasecampoutfitters.com',
        EVA_Hours__c = 421,
        Certification_Level__c = 'Master Lunar Alpinist',
        Medical_Clearance_Date__c = Date.newInstance(2026, 2, 22),
        Emergency_Contact__c = 'Irina Volkov (+7-915-555-2210)'
    ),
    new Lunar_Explorer__c(
        Full_Name__c = 'Amara Okonkwo',
        Email__c = 'amara.okonkwo@lunarbasecampoutfitters.com',
        EVA_Hours__c = 498,
        Certification_Level__c = 'Master Lunar Alpinist',
        Medical_Clearance_Date__c = Date.newInstance(2026, 4, 1),
        Emergency_Contact__c = 'Chike Okonkwo (+234-803-555-7721)'
    )
};
insert explorers;

Map<String, Id> explorerByName = new Map<String, Id>();
for (Lunar_Explorer__c explorer : explorers) {
    explorerByName.put(explorer.Full_Name__c, explorer.Id);
}

List<Gear_Item__c> gearItems = new List<Gear_Item__c>{
    new Gear_Item__c(Item_Name__c='Apollo Heritage Pressure Suit X7', Category__c='Pressure Suit', Serial_Number__c='LBO-2024-001', Maintenance_Due_Date__c=Date.newInstance(2026,5,22), Status__c='Available', Daily_Rental_Rate__c=4800, Purchase_Price__c=245000),
    new Gear_Item__c(Item_Name__c='CraterGrip Magnetic Boots', Category__c='Boots', Serial_Number__c='LBO-2024-002', Maintenance_Due_Date__c=Date.newInstance(2026,6,14), Status__c='Rented', Daily_Rental_Rate__c=1200, Purchase_Price__c=38000),
    new Gear_Item__c(Item_Name__c='HorizonLink Comm Headset', Category__c='Communication Device', Serial_Number__c='LBO-2024-003', Maintenance_Due_Date__c=Date.newInstance(2026,4,28), Status__c='Maintenance', Daily_Rental_Rate__c=850, Purchase_Price__c=22000),
    new Gear_Item__c(Item_Name__c='TitanThread Tether Kit', Category__c='Tether Kit', Serial_Number__c='LBO-2024-004', Maintenance_Due_Date__c=Date.newInstance(2026,7,7), Status__c='Available', Daily_Rental_Rate__c=980, Purchase_Price__c=26000),
    new Gear_Item__c(Item_Name__c='LunarBreath O2 System', Category__c='Oxygen System', Serial_Number__c='LBO-2024-005', Maintenance_Due_Date__c=Date.newInstance(2026,5,30), Status__c='Available', Daily_Rental_Rate__c=3200, Purchase_Price__c=146000),
    new Gear_Item__c(Item_Name__c='ShackletonPro Ice Anchor Set', Category__c='Crater Anchor', Serial_Number__c='LBO-2024-006', Maintenance_Due_Date__c=Date.newInstance(2026,8,11), Status__c='Available', Daily_Rental_Rate__c=1500, Purchase_Price__c=45000),
    new Gear_Item__c(Item_Name__c='Selene Mk-IV Pressure Suit', Category__c='Pressure Suit', Serial_Number__c='LBO-2024-007', Maintenance_Due_Date__c=Date.newInstance(2026,6,1), Status__c='Rented', Daily_Rental_Rate__c=5000, Purchase_Price__c=250000),
    new Gear_Item__c(Item_Name__c='RegolithGuard Gloves', Category__c='Gloves', Serial_Number__c='LBO-2024-008', Maintenance_Due_Date__c=Date.newInstance(2026,4,19), Status__c='Available', Daily_Rental_Rate__c=620, Purchase_Price__c=18000),
    new Gear_Item__c(Item_Name__c='AetherPulse Comm Relay', Category__c='Communication Device', Serial_Number__c='LBO-2024-009', Maintenance_Due_Date__c=Date.newInstance(2026,9,5), Status__c='Available', Daily_Rental_Rate__c=1400, Purchase_Price__c=41000),
    new Gear_Item__c(Item_Name__c='Polaris O2 Redundancy Pack', Category__c='Oxygen System', Serial_Number__c='LBO-2024-010', Maintenance_Due_Date__c=Date.newInstance(2026,5,9), Status__c='Maintenance', Daily_Rental_Rate__c=2700, Purchase_Price__c=98000),
    new Gear_Item__c(Item_Name__c='MoonStride Traction Boots', Category__c='Boots', Serial_Number__c='LBO-2024-011', Maintenance_Due_Date__c=Date.newInstance(2026,7,30), Status__c='Available', Daily_Rental_Rate__c=1100, Purchase_Price__c=34000),
    new Gear_Item__c(Item_Name__c='Helios Thermal Gloves', Category__c='Gloves', Serial_Number__c='LBO-2024-012', Maintenance_Due_Date__c=Date.newInstance(2026,6,25), Status__c='Retired', Daily_Rental_Rate__c=500, Purchase_Price__c=15000),
    new Gear_Item__c(Item_Name__c='RidgeLock Anchor Pair', Category__c='Crater Anchor', Serial_Number__c='LBO-2024-013', Maintenance_Due_Date__c=Date.newInstance(2026,8,24), Status__c='Rented', Daily_Rental_Rate__c=1350, Purchase_Price__c=39000),
    new Gear_Item__c(Item_Name__c='Orion Safety Tether Pro', Category__c='Tether Kit', Serial_Number__c='LBO-2024-014', Maintenance_Due_Date__c=Date.newInstance(2026,10,2), Status__c='Available', Daily_Rental_Rate__c=1050, Purchase_Price__c=29500),
    new Gear_Item__c(Item_Name__c='LunaWave EVA Comms Pack', Category__c='Communication Device', Serial_Number__c='LBO-2024-015', Maintenance_Due_Date__c=Date.newInstance(2026,5,17), Status__c='Rented', Daily_Rental_Rate__c=1600, Purchase_Price__c=52000)
};
insert gearItems;

Map<String, Id> gearByName = new Map<String, Id>();
for (Gear_Item__c gear : gearItems) {
    gearByName.put(gear.Item_Name__c, gear.Id);
}

List<Expedition_Booking__c> expeditions = new List<Expedition_Booking__c>{
    new Expedition_Booking__c(Expedition_Name__c='Tycho Shadow Traverse', Explorer__c=explorerByName.get('Dmitri Volkov'), Launch_Date__c=Date.newInstance(2026,4,29), Return_Date__c=Date.newInstance(2026,5,5), Landing_Site__c='Tycho Crater', Status__c='Confirmed', Total_Cost__c=285000),
    new Expedition_Booking__c(Expedition_Name__c='Mare Tranquillitatis Heritage Walk', Explorer__c=explorerByName.get('Sarah Chen'), Launch_Date__c=Date.newInstance(2026,5,13), Return_Date__c=Date.newInstance(2026,5,16), Landing_Site__c='Mare Tranquillitatis', Status__c='Planned', Total_Cost__c=92000),
    new Expedition_Booking__c(Expedition_Name__c='Shackleton Ice Core Expedition', Explorer__c=explorerByName.get('Amara Okonkwo'), Launch_Date__c=Date.newInstance(2026,5,28), Return_Date__c=Date.newInstance(2026,6,7), Landing_Site__c='Shackleton Rim', Status__c='Confirmed', Total_Cost__c=472000),
    new Expedition_Booking__c(Expedition_Name__c='Hadley Rille Navigation Drill', Explorer__c=explorerByName.get('Marcus Rodriguez'), Launch_Date__c=Date.newInstance(2026,6,18), Return_Date__c=Date.newInstance(2026,6,23), Landing_Site__c='Hadley Rille', Status__c='Planned', Total_Cost__c=158000),
    new Expedition_Booking__c(Expedition_Name__c='Aristarchus Plateau Rim Survey', Explorer__c=explorerByName.get('Yuki Tanaka'), Launch_Date__c=Date.newInstance(2026,7,9), Return_Date__c=Date.newInstance(2026,7,15), Landing_Site__c='Aristarchus Plateau', Status__c='Confirmed', Total_Cost__c=246000),
    new Expedition_Booking__c(Expedition_Name__c='Tycho Crater Night EVA', Explorer__c=explorerByName.get('Amara Okonkwo'), Launch_Date__c=Date.newInstance(2026,8,14), Return_Date__c=Date.newInstance(2026,8,20), Landing_Site__c='Tycho Crater', Status__c='Planned', Total_Cost__c=332000),
    new Expedition_Booking__c(Expedition_Name__c='Shackleton Rim Solar Array Repair', Explorer__c=explorerByName.get('Dmitri Volkov'), Launch_Date__c=Date.newInstance(2026,9,10), Return_Date__c=Date.newInstance(2026,9,17), Landing_Site__c='Shackleton Rim', Status__c='Planned', Total_Cost__c=389000),
    new Expedition_Booking__c(Expedition_Name__c='Tranquillitatis Habitat Expansion', Explorer__c=explorerByName.get('Marcus Rodriguez'), Launch_Date__c=Date.newInstance(2026,10,8), Return_Date__c=Date.newInstance(2026,10,18), Landing_Site__c='Mare Tranquillitatis', Status__c='Planned', Total_Cost__c=455000)
};
insert expeditions;

Map<String, Id> expeditionByName = new Map<String, Id>();
for (Expedition_Booking__c expedition : expeditions) {
    expeditionByName.put(expedition.Expedition_Name__c, expedition.Id);
}

insert new List<Safety_Certification__c>{
    new Safety_Certification__c(Explorer__c=explorerByName.get('Sarah Chen'), Certification_Type__c='Basic EVA', Issued_Date__c=Date.newInstance(2025,5,20), Expiry_Date__c=Date.newInstance(2026,5,20), Instructor_Name__c='Cmdr. Helena Park', Pass_Status__c=true),
    new Safety_Certification__c(Explorer__c=explorerByName.get('Sarah Chen'), Certification_Type__c='Crater Navigation', Issued_Date__c=Date.newInstance(2025,11,18), Expiry_Date__c=Date.newInstance(2026,11,18), Instructor_Name__c='Lt. Owen Briggs', Pass_Status__c=true),
    new Safety_Certification__c(Explorer__c=explorerByName.get('Marcus Rodriguez'), Certification_Type__c='Basic EVA', Issued_Date__c=Date.newInstance(2025,3,12), Expiry_Date__c=Date.newInstance(2026,3,12), Instructor_Name__c='Dr. Leila Hassan', Pass_Status__c=true),
    new Safety_Certification__c(Explorer__c=explorerByName.get('Marcus Rodriguez'), Certification_Type__c='Emergency Repair', Issued_Date__c=Date.newInstance(2025,12,2), Expiry_Date__c=Date.newInstance(2026,12,2), Instructor_Name__c='Eng. Mateo Alvarez', Pass_Status__c=true),
    new Safety_Certification__c(Explorer__c=explorerByName.get('Yuki Tanaka'), Certification_Type__c='Crater Navigation', Issued_Date__c=Date.newInstance(2024,10,15), Expiry_Date__c=Date.newInstance(2025,10,15), Instructor_Name__c='Lt. Owen Briggs', Pass_Status__c=true),
    new Safety_Certification__c(Explorer__c=explorerByName.get('Yuki Tanaka'), Certification_Type__c='Low-G Climbing', Issued_Date__c=Date.newInstance(2025,9,5), Expiry_Date__c=Date.newInstance(2026,9,5), Instructor_Name__c='Cmdr. Helena Park', Pass_Status__c=true),
    new Safety_Certification__c(Explorer__c=explorerByName.get('Dmitri Volkov'), Certification_Type__c='Basic EVA', Issued_Date__c=Date.newInstance(2025,2,9), Expiry_Date__c=Date.newInstance(2026,2,9), Instructor_Name__c='Dr. Leila Hassan', Pass_Status__c=true),
    new Safety_Certification__c(Explorer__c=explorerByName.get('Dmitri Volkov'), Certification_Type__c='Emergency Repair', Issued_Date__c=Date.newInstance(2025,8,21), Expiry_Date__c=Date.newInstance(2026,8,21), Instructor_Name__c='Eng. Mateo Alvarez', Pass_Status__c=true),
    new Safety_Certification__c(Explorer__c=explorerByName.get('Dmitri Volkov'), Certification_Type__c='Solar Radiation Protocol', Issued_Date__c=Date.newInstance(2025,10,11), Expiry_Date__c=Date.newInstance(2026,10,11), Instructor_Name__c='Dr. Priya Menon', Pass_Status__c=true),
    new Safety_Certification__c(Explorer__c=explorerByName.get('Amara Okonkwo'), Certification_Type__c='Low-G Climbing', Issued_Date__c=Date.newInstance(2025,1,29), Expiry_Date__c=Date.newInstance(2026,1,29), Instructor_Name__c='Cmdr. Helena Park', Pass_Status__c=true),
    new Safety_Certification__c(Explorer__c=explorerByName.get('Amara Okonkwo'), Certification_Type__c='Solar Radiation Protocol', Issued_Date__c=Date.newInstance(2025,12,14), Expiry_Date__c=Date.newInstance(2026,12,14), Instructor_Name__c='Dr. Priya Menon', Pass_Status__c=true),
    new Safety_Certification__c(Explorer__c=explorerByName.get('Amara Okonkwo'), Certification_Type__c='Crater Navigation', Issued_Date__c=Date.newInstance(2025,4,30), Expiry_Date__c=Date.newInstance(2026,4,30), Instructor_Name__c='Lt. Owen Briggs', Pass_Status__c=true)
};

insert new List<Expedition_Gear__c>{
    new Expedition_Gear__c(Expedition_Booking__c=expeditionByName.get('Tycho Shadow Traverse'), Gear_Item__c=gearByName.get('Apollo Heritage Pressure Suit X7'), Quantity__c=2),
    new Expedition_Gear__c(Expedition_Booking__c=expeditionByName.get('Tycho Shadow Traverse'), Gear_Item__c=gearByName.get('LunarBreath O2 System'), Quantity__c=2),
    new Expedition_Gear__c(Expedition_Booking__c=expeditionByName.get('Tycho Shadow Traverse'), Gear_Item__c=gearByName.get('ShackletonPro Ice Anchor Set'), Quantity__c=1),
    new Expedition_Gear__c(Expedition_Booking__c=expeditionByName.get('Mare Tranquillitatis Heritage Walk'), Gear_Item__c=gearByName.get('CraterGrip Magnetic Boots'), Quantity__c=4),
    new Expedition_Gear__c(Expedition_Booking__c=expeditionByName.get('Mare Tranquillitatis Heritage Walk'), Gear_Item__c=gearByName.get('HorizonLink Comm Headset'), Quantity__c=3),
    new Expedition_Gear__c(Expedition_Booking__c=expeditionByName.get('Shackleton Ice Core Expedition'), Gear_Item__c=gearByName.get('Selene Mk-IV Pressure Suit'), Quantity__c=3),
    new Expedition_Gear__c(Expedition_Booking__c=expeditionByName.get('Shackleton Ice Core Expedition'), Gear_Item__c=gearByName.get('Polaris O2 Redundancy Pack'), Quantity__c=2),
    new Expedition_Gear__c(Expedition_Booking__c=expeditionByName.get('Shackleton Ice Core Expedition'), Gear_Item__c=gearByName.get('RidgeLock Anchor Pair'), Quantity__c=2),
    new Expedition_Gear__c(Expedition_Booking__c=expeditionByName.get('Hadley Rille Navigation Drill'), Gear_Item__c=gearByName.get('TitanThread Tether Kit'), Quantity__c=2),
    new Expedition_Gear__c(Expedition_Booking__c=expeditionByName.get('Hadley Rille Navigation Drill'), Gear_Item__c=gearByName.get('MoonStride Traction Boots'), Quantity__c=3),
    new Expedition_Gear__c(Expedition_Booking__c=expeditionByName.get('Aristarchus Plateau Rim Survey'), Gear_Item__c=gearByName.get('Apollo Heritage Pressure Suit X7'), Quantity__c=2),
    new Expedition_Gear__c(Expedition_Booking__c=expeditionByName.get('Aristarchus Plateau Rim Survey'), Gear_Item__c=gearByName.get('AetherPulse Comm Relay'), Quantity__c=2),
    new Expedition_Gear__c(Expedition_Booking__c=expeditionByName.get('Tycho Crater Night EVA'), Gear_Item__c=gearByName.get('LunarBreath O2 System'), Quantity__c=3),
    new Expedition_Gear__c(Expedition_Booking__c=expeditionByName.get('Tycho Crater Night EVA'), Gear_Item__c=gearByName.get('Orion Safety Tether Pro'), Quantity__c=3),
    new Expedition_Gear__c(Expedition_Booking__c=expeditionByName.get('Shackleton Rim Solar Array Repair'), Gear_Item__c=gearByName.get('ShackletonPro Ice Anchor Set'), Quantity__c=2),
    new Expedition_Gear__c(Expedition_Booking__c=expeditionByName.get('Shackleton Rim Solar Array Repair'), Gear_Item__c=gearByName.get('LunaWave EVA Comms Pack'), Quantity__c=4),
    new Expedition_Gear__c(Expedition_Booking__c=expeditionByName.get('Tranquillitatis Habitat Expansion'), Gear_Item__c=gearByName.get('Selene Mk-IV Pressure Suit'), Quantity__c=3),
    new Expedition_Gear__c(Expedition_Booking__c=expeditionByName.get('Tranquillitatis Habitat Expansion'), Gear_Item__c=gearByName.get('Polaris O2 Redundancy Pack'), Quantity__c=2)
};

System.debug('Lunar Basecamp sample data inserted: 5 explorers, 15 gear items, 8 expeditions, 12 certifications, 18 expedition gear links.');
