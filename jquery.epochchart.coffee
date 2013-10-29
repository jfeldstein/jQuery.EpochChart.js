( ($) -> 
  
  tallestPoint = (lines, x) ->
    computedValues = $.map lines, (line) ->
      prevPoint = null
      ret = null
      $.map line['data'], (datum, i) ->
        if x >= datum['x']
          prevPoint = datum
          return

        if x < datum['x']
          if prevPoint == null
            ret = datum['y']
            return

          # How far between the two x-points?
          xdiff = x-prevPoint['x']
          slope = ((datum['y']-prevPoint['y'])/(datum['x']-prevPoint['x']))
          ret = prevPoint['y'] + slope*(x-prevPoint['x'])
          return
      ret

    ret = null
    $.each computedValues, (i, v) ->
      ret = v if v? and (not ret? or ret<v)
    ret

  defaults = 
    marker: 'url(marker.png)'

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
            symbol: opts['marker']
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
        x: new Date(data[0])
        y: data[1]

      {
        type: 'spline',
        name: line.name,
        data: lineData
      }  

    markerData = $.map markers, (marker) ->
      x: new Date(marker[0])
      y: tallestPoint(lines, marker[0])
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