/* global */

const randomScalingFactor = function () {
    return Math.round(Math.random() * 100);
};

// Disk Usage Chart config.
// Todo: get data from mssql 
const diskusageconfig = {
    type: 'pie',
    data: {
        datasets: [{
            data: [
                randomScalingFactor(),
                randomScalingFactor()
            ],
            backgroundColor: [
                window.chartColors.green,
                window.chartColors.darkslategrey
            ],
            label: 'Dataset 1'
        }],
        labels: [
            'Available',
            'Used Space'
        ]
    },
    options: {
        responsive: true,
        legend: {
            display: true,
            position: 'top',
        },
        title: {
            display: false,
            text: 'Disk Usage'
        },
        animation: {
            animateScale: true,
            animateRotate: true
        }
    }
};

const servermemoryconfig = {
    type: 'doughnut',
    data: {
        datasets: [{
            data: [
                randomScalingFactor(),
                randomScalingFactor()
            ],
            backgroundColor: [
                window.chartColors.green,
                window.chartColors.darkslategrey
            ],
            label: 'Dataset 2'
        }],
        labels: [
            'Available',
            'Used Memory'
        ]
    },
    options: {
        responsive: true,
        legend: {
            display: true,
            position: 'top',
        },
        title: {
            display: false,
            text: 'Physical Memory'
        },
        animation: {
            animateScale: true,
            animateRotate: true
        }
    }
};

const cpuconfig = {
    type: 'line',
    data: {
        labels: ['1', '2', '3', '4', '5', '6', '7', '1', '2', '3', '4', '5',
            '6', '7', '1', '2', '3', '4', '5', '6', '7',
            '1', '2', '3', '4', '5', '6', '7', '1', '2', '3', '4',
            '5', '6', '7', '1', '2', '3', '4', '5', '6', '7', '1', '2', '3', '4', '5', '6', '7'
        ],
        datasets: [{
            label: 'CPU',
            backgroundColor: window.chartColors.darkslategrey,
            borderColor: window.chartColors.darkslategrey,
            fill: false,
            data: [
                randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(),
                randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(),
                randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(),
                randomScalingFactor(), randomScalingFactor(), randomScalingFactor(),
                randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(),
                randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(),
                randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor(), randomScalingFactor()
            ],
        }]
    },
    options: {
        responsive: true,
        title: {
            display: false,
            text: 'Chart.js Line Chart - Logarithmic'
        },
        scales: {
            xAxes: [{
                display: false,
            }],
            yAxes: [{
                display: true,
            }]
        }
    }
};

