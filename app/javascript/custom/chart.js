import Chart from "chart.js/auto";

window.chartInstance = null;
window.initChart = function(opt){
  const ctx = document.getElementById('total-chart');
  if (ctx) {
    window.chartInstance = new Chart(ctx, {
      type: 'doughnut',
      data: {
        labels: opt.map((i) => i.title),
        datasets: [{
          data: opt.map((i) => i.value),
          backgroundColor: opt.map((i) => i.color),
          borderWidth: 1
        }]
      },
      options: {
        plugins: {
          legend: {
            display: false
          },
          tooltip: {
            callbacks: {
              label: function(context) {
                let label = context.label || '';
                let value = context.parsed;
                return `${label}: ${value.toFixed(1)}%`;
              }
            }
          }
        },
        responsive: true,
      }
    });
  }
}
