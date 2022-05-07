load "sub_toolbox.ncl"
load "get_path.ncl"
; load "indices.ncl"
load "sub_plot.ncl"
load "sub_calc.ncl"
load "sub_read.ncl"
begin
  type = "SST"
  type@year = ispan(1979,2020,1)
  type@months = (/7,8/)
    ; type@source = "jra55"
  type@range = (/0,90,180,360/)
  ; range = (/0,90,180,360/)
  opt = True
  opt@method = "clim"
  opt@detrend = True
  var_anom = process(type,opt)
  printVarSummary(var_anom)
end