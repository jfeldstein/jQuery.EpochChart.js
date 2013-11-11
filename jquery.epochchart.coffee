$ = jQuery

Date.prototype.format = (format) ->
  o =
    "M+" : this.getMonth()+1  #month
    "d+" : this.getDate()     #day
    "h+" : this.getHours()    #hour
    "m+" : this.getMinutes()  #minute
    "s+" : this.getSeconds()  #second
    "q+" : Math.floor((this.getMonth()+3)/3)   #quarter
    "S"  : this.getMilliseconds() #millisecond

  if(/(y+)/.test(format)) 
    format=format.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length))
  for k in o
    if(new RegExp("("+ k +")").test(format))
      format = format.replace(RegExp.$1, if (RegExp.$1.length==1) then o[k] else ("00"+ o[k]).substr((""+ o[k]).length))
  return format


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
  dateFormat: '%b %e'
  tooltipX: 30
  tooltipY: 10

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
        day: opts.dateFormat
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
      formatter: ->
        date = Highcharts.dateFormat opts.dateFormat, @x
        s = '<b>' + date + '</b><br />'
        if @point.name? 
          s += @point.name
        else
          s += "#{@series.name}: #{@y}"
        s
      positioner: ->
        x: opts.tooltipX
        y: opts.tooltipY
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
