( ($) -> 

  $.fn.epochchart = (lines, markers, highchartsOpts={}) ->
    # Support for single or multiple lines
    lines = [lines] if Object.prototype.toString.call( lines ) != '[object Array]'

    # Default highcharts options
    defaultHighchartsOpts = 
      title:
        text: null
      xAxis: 
        type: 'datetime'
        dateTimeLabelFormats: 
          month: '%e. %b'
          year: '%b'
      yAxis: 
        title: 
          text: null
        plotLines: [
          value: 0
          width: 1
          color: '#808080'
        ]
      plotOptions:
        scatter:
          marker: 
            symbol: "url(/line.png)"
            states: 
              hover:
                enabled: true
                lineColor: 'rgb(100,100,100)'
          states: 
            hover: 
              marker: 
                enabled: false
          tooltip: 
            enabled: true
            headerFormat: '',
            pointFormat: '{point.name}'
        spline: 
          marker: 
            enabled: false
      legend: 
        enabled: false

    # Build options for this chart
    highchartsOpts = $.extend true, defaultHighchartsOpts, highchartsOpts

    # Build data
    markerData = $.map markers, (marker) ->
      x: new Date(marker[0]*1000)
      y: 500
      name: marker[1]
    markerLine = 
      type: 'scatter'
      name: 'Markers'
      data: markerData

    lines = $.map lines, (line) ->
      lineData = $.map line.data, (data) ->
        x: new Date(data[0]*1000)
        y: data[1]

      {
        type: 'spline',
        name: line.name,
        data: lineData
      }  

    lines.push markerLine


    # Build data into highcharts options for final chart hash
    chart = $.extend true, highchartsOpts,
      series: lines

    # Build the chart
    $(this).highcharts chart

) jQuery