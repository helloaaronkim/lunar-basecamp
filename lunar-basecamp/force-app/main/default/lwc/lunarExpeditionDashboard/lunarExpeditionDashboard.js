import { LightningElement, wire } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import { loadScript } from 'lightning/platformResourceLoader';
import getDashboardData from '@salesforce/apex/LunarExpeditionDashboardController.getDashboardData';
import CHART_JS from '@salesforce/resourceUrl/chartJs';

const AUTO_REFRESH_MS = 30000;
const COUNTDOWN_TICK_MS = 1000;

export default class LunarExpeditionDashboard extends LightningElement {
    expeditions = [];
    mapMarkers = [];
    monthlyLabels = [];
    monthlyValues = [];
    siteLabels = [];
    siteValues = [];
    errorMessage;
    isLoading = true;

    chartJsInitialized = false;
    monthChart;
    siteChart;
    wiredResult;
    autoRefreshTimer;
    countdownTimer;

    @wire(getDashboardData)
    wiredDashboard(result) {
        this.wiredResult = result;
        const { data, error } = result;

        if (data) {
            this.errorMessage = undefined;
            this.buildDashboard(data);
            this.isLoading = false;
        } else if (error) {
            this.errorMessage = 'Unable to load dashboard data.';
            this.isLoading = false;
        }
    }

    connectedCallback() {
        this.autoRefreshTimer = window.setInterval(() => {
            this.handleRefresh();
        }, AUTO_REFRESH_MS);

        this.countdownTimer = window.setInterval(() => {
            this.updateCountdowns();
        }, COUNTDOWN_TICK_MS);
    }

    disconnectedCallback() {
        if (this.autoRefreshTimer) {
            window.clearInterval(this.autoRefreshTimer);
        }
        if (this.countdownTimer) {
            window.clearInterval(this.countdownTimer);
        }
        this.destroyCharts();
    }

    renderedCallback() {
        if (this.chartJsInitialized) {
            return;
        }
        this.chartJsInitialized = true;

        loadScript(this, CHART_JS)
            .then(() => {
                this.renderCharts();
            })
            .catch(() => {
                this.errorMessage = 'Chart.js failed to load. Deploy chartJs static resource.';
            });
    }

    get hasExpeditions() {
        return this.expeditions.length > 0;
    }

    async handleRefresh() {
        this.isLoading = true;
        await refreshApex(this.wiredResult);
        this.isLoading = false;
    }

    buildDashboard(data) {
        const now = new Date();
        this.expeditions = (data.expeditions || []).map((item) => {
            const launchDate = item.launchDate ? new Date(`${item.launchDate}T00:00:00`) : null;
            return {
                id: item.id,
                expeditionName: item.expeditionName,
                explorerName: item.explorerName,
                explorerInitials: item.explorerInitials,
                launchDate,
                launchDateFormatted: launchDate
                    ? launchDate.toLocaleDateString(undefined, { year: 'numeric', month: 'short', day: 'numeric' })
                    : 'TBD',
                countdownText: this.formatCountdown(launchDate, now),
                landingSite: item.landingSite,
                complianceStatus: item.complianceStatus,
                complianceClass: this.getComplianceClass(item.complianceStatus),
                totalGearItems: item.totalGearItems ?? 0,
                latitude: item.latitude,
                longitude: item.longitude
            };
        });

        this.mapMarkers = this.expeditions.map((expedition) => ({
            location: {
                Latitude: expedition.latitude,
                Longitude: expedition.longitude
            },
            title: expedition.expeditionName,
            description: `${expedition.landingSite} | ${expedition.complianceStatus}`,
            icon: 'custom:custom14'
        }));

        this.monthlyLabels = (data.bookingsByMonth || []).map((point) => point.label);
        this.monthlyValues = (data.bookingsByMonth || []).map((point) => point.value);
        this.siteLabels = (data.bookingsByLandingSite || []).map((point) => point.label);
        this.siteValues = (data.bookingsByLandingSite || []).map((point) => point.value);

        this.renderCharts();
    }

    updateCountdowns() {
        const now = new Date();
        this.expeditions = this.expeditions.map((expedition) => ({
            ...expedition,
            countdownText: this.formatCountdown(expedition.launchDate, now)
        }));
    }

    formatCountdown(launchDate, now) {
        if (!launchDate) {
            return 'Launch date unavailable';
        }

        const diffMs = launchDate.getTime() - now.getTime();
        if (diffMs <= 0) {
            return 'Launched';
        }

        const totalHours = Math.floor(diffMs / (1000 * 60 * 60));
        const days = Math.floor(totalHours / 24);
        const hours = totalHours % 24;
        return `T-${days}d ${hours}h`;
    }

    getComplianceClass(status) {
        if (status === 'Cleared') {
            return 'status-badge badge-green';
        }
        if (status === 'Pending') {
            return 'status-badge badge-yellow';
        }
        return 'status-badge badge-red';
    }

    renderCharts() {
        if (!window.Chart) {
            return;
        }

        const monthCanvas = this.template.querySelector('canvas.month-chart');
        const siteCanvas = this.template.querySelector('canvas.site-chart');
        if (!monthCanvas || !siteCanvas) {
            return;
        }

        this.destroyCharts();

        this.monthChart = new window.Chart(monthCanvas.getContext('2d'), {
            type: 'bar',
            data: {
                labels: this.monthlyLabels,
                datasets: [
                    {
                        label: 'Bookings',
                        data: this.monthlyValues,
                        backgroundColor: 'rgba(99, 179, 237, 0.7)',
                        borderColor: 'rgba(99, 179, 237, 1)',
                        borderWidth: 1
                    }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: { legend: { labels: { color: '#d8e6ff' } } },
                scales: {
                    x: { ticks: { color: '#c6d7ff' }, grid: { color: 'rgba(122, 143, 179, 0.2)' } },
                    y: {
                        beginAtZero: true,
                        ticks: { color: '#c6d7ff', precision: 0 },
                        grid: { color: 'rgba(122, 143, 179, 0.2)' }
                    }
                }
            }
        });

        this.siteChart = new window.Chart(siteCanvas.getContext('2d'), {
            type: 'doughnut',
            data: {
                labels: this.siteLabels,
                datasets: [
                    {
                        data: this.siteValues,
                        backgroundColor: ['#7fb3ff', '#66d9e8', '#ffd166', '#ff9f6e', '#ff6f91']
                    }
                ]
            },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: 'bottom',
                        labels: { color: '#d8e6ff' }
                    }
                }
            }
        });
    }

    destroyCharts() {
        if (this.monthChart) {
            this.monthChart.destroy();
            this.monthChart = null;
        }
        if (this.siteChart) {
            this.siteChart.destroy();
            this.siteChart = null;
        }
    }
}
