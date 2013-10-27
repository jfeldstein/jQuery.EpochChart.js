( ($) -> 
  
  defaults = 
    markerSrc: 'url(marker.png)'

  $.fn.epochchart = (lines, markers, opts={}) ->
    opts = $.extend true, {}, defaults, opts

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
      tooltip:
        shared: true
        crosshairs: true
      plotOptions:
        scatter:
          marker: 
            symbol: opts['markerSrc']
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
    highchartsOpts = $.extend true, defaultHighchartsOpts, opts['highchartsOpts']

    # Build data
    maxY = null;
    lines = $.map lines, (line) ->
      lineData = $.map line.data, (data) ->
        maxY = data[1] if maxY==null or data[1] > maxY
        x: new Date(data[0]*1000)
        y: data[1]

      {
        type: 'spline',
        name: line.name,
        data: lineData
      }  

    markerData = $.map markers, (marker) ->
      x: new Date(marker[0]*1000)
      y: (1.03*maxY)
      name: marker[1]
    markerLine = 
      type: 'scatter'
      name: 'Markers'
      data: markerData

    lines.push markerLine


    # Build data into highcharts options for final chart hash
    chart = $.extend true, highchartsOpts,
      series: lines

    # Build the chart
    $(this).highcharts chart

) jQuery