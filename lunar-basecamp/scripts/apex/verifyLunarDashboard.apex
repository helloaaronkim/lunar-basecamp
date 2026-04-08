LunarExpeditionDashboardController.DashboardResponse response =
    LunarExpeditionDashboardController.getDashboardData();

System.debug('EXPEDITIONS=' + response.expeditions.size());
System.debug('MONTH_POINTS=' + response.bookingsByMonth.size());
System.debug('SITE_POINTS=' + response.bookingsByLandingSite.size());
