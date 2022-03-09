; 说明文档：https://www.craft.do/s/GYIYbC0iW53gbL


undef("readpath")
function readpath(type)
begin
path = asciiread("~/LLF/path.txt",3,"string")
return(path(type)) 
end





undef("read_SST")
  function read_SST(type,range,opt)
  begin
  get_path(type)
  nyear = dimsizes(type@year)
  f = addfile(type@file_path,"r")
  type@preyear = get_res_value_keep(type,"preyear",False)
  type@posyear = get_res_value_keep(type,"posyear",False)
  opt@detrend  = get_res_value_keep(opt,"detrend",False)
  type@year = type@year - where(type@preyear,1,0) + where(type@posyear,1,0)
  t = (/min(type@year),max(type@year)/) 
  if(max(type@months) .gt. 12) t(1) = t(1)+1 end if
  if(max(type@months) .gt. 24) t(1) = t(1)+1 end if
  ; ind_months = conform_dims((/dimsizes(type@year),dimsizes(type@months)/),ispan(0,dimsizes(type@year)*12-12,12),0)+conform_dims((/dimsizes(type@year),dimsizes(type@months)/),type@months-1,1)
  ; mon = ndtooned(ind_months)
  ; f = addfile(readpath(0)+"SST/HANO_SSTV5.mon.mean.nc", "r")
  if(type@source .eq. "combined")
    time = f->time
    year = time/100
    print(year)
    month = time-100*year
  else
    utc_date = cd_calendar(f->time, 0)
    year     = floattointeger(utc_date(:,0))
    ; print(year)
    month    = floattointeger(utc_date(:,1))
  end if
  mon_ind = ind(year .ge. min(type@year) .and. year .le. max(type@year) .and. (month .ge. min(type@months) .and. month .le. max(type@months))) 
  ;-------------------
  if(range(2) .lt. 0 .and. type@source .ne. "HadISST")
    tem = f->$type@var$(mon_ind,{range(0):range(1)},:)
    ; lon = ispan(0,358,2)*1. 
    ; lon@units = "degrees_east"
    ; tem&lon := lon
    ; tem0 = lonPivot(tem, range(2)+360)
    tem0 = lonFlip(tem)
    tem := tem0(:,:,{range(2):range(3)})
  else
    tem = f->$type@var$(mon_ind,{range(0):range(1)},{range(2):range(3)})
  end if
  dim = dimsizes(tem)
  if(dimsizes(type@months) .eq. 1)
    var = tem
    var!1 = "lat"
    var!2 = "lon"
  else
    var = reshape(tem,(/nyear,dim(0)/nyear,dim(1),dim(2)/))
    copy_VarCoords(tem(0,:,:),var(0,0,:,:))
    var!0 = "year"
    var!1 = "month"
    var!2 = "lat"
    var!3 = "lon"
    var&month = type@months
    var&year = type@year
    var := var({year|:},{month|:},{lat|:},{lon|:})
  end if
  var@name = "SST"
  return(var)
end

undef("read_precip")
  function read_precip(type,range,opt)
  begin
  ; 目前来看可以考虑和read_sst合并
  get_path(type)
  nyear = dimsizes(type@year)
  f = addfile(type@file_path,"r")
  time = cd_calendar(f->time, -1)
  ; year0 = conform_dims((/dimsizes(type@year),dimsizes(type@months)/),(type@year-1948)*12,0)
  ; month = year0+conform_dims((/dimsizes(type@year),dimsizes(type@months)/),type@months-1,1)
  ; mon = ndtooned(month)
  ;-----方法二，还未测试
  utc_date = cd_calendar(f->time, 0)
  year     = floattointeger(utc_date(:,0))
  month    = floattointeger(utc_date(:,1))
  mon_ind = ind(year .ge. min(type@year) .and. year .le. max(type@year) .and. (month .ge. min(type@months) .and. month .le. max(type@months))) 
  if(range(2) .lt. 0)
    tem = f->$var_name$(mon_ind,{range(0):range(1)},:)
    ; lon = ispan(0,358,2)*1. 
    ; lon@units = "degrees_east"
    ; tem&lon := lon
    tem0 = lonFlip(tem)
    ; tem0 = lonPivot(tem, range(2)+360)
    tem := tem0(:,:,{range(2):range(3)})
  else
    tem = f->$var_name$(mon_ind,{range(0):range(1)},{range(2):range(3)})
  end if
  dim = dimsizes(tem)
  if(dimsizes(type@months) .eq. 1)
    var = tem
  else
    var = reshape(tem,(/nyear,dim(0)/nyear,dim(1),dim(2)/))
    copy_VarCoords(tem(0,:,:),var(0,0,:,:))
    ; var!0 = "year"
    ; var!1 = "month"
    ; var&month = type@months
    ; var&year = type@year
    ; var := var({year|:},{month|:},{lat|:},{lon|:})
  end if
  var@name = "precip"
  return(var)
end

undef("read_jra55")
  function read_jra55(type,range,opt)
  begin
  get_path(type)
  months = (/"J","F","M","A","M","J","J","A","S","O","N","D","J","F","M","A","M","J","J","A","S","O","N","D","J","F","M","A","M","J","J","A","S","O","N","D"/)
  nyear = dimsizes(type@year)
  ind_year = type@year-1958
  opt@names   := (/"SST","SLP","SAT","U","V","H","T","vv","SIC","SAT","U2m","V2m","pre","OLR","relv","strm","precip","reld","vpot","q","sp"/)
  path = (/"none","surf/SLP","surf/SAT","u/u","v/v", "hgt/hgt","T/T","vv/vv","none","none","surf/U2m","surf/V2m","none","none","relv/relv","strm/strm","none","reld/reld","vpot/vpot","q/spfh","surf/SP"/)
  name = (/"none",  "SLP",        "SAT",        "u",       "v",      "hgt",        "T",     "vv",       "none","none","U2m","V2m","none","none","relv","strm","precip","reld","vpot","spfh","SP"/)
  files = systemfunc("ls "+readpath(2)+"jra55/"+path(type)+".mn.*.nc")
  f = addfiles(files, "r") 
  ListSetType(f, "join")  

  isLevel  = isfilevarcoord(f[0], name(type), "level");判断变量是否有层次信息
  if(range(2) .lt. 0)
    if(isLevel)
      tem = f[ind_year]->$name(type)$(:,type@months-1,{type@level},{range(0):range(1)},:)
    else
      tem = f[ind_year]->$name(type)$(:,type@months-1,{range(0):range(1)},:)
    end if
    tem0 = lonPivot(tem, range(2)+360)
    ; printVarSummary(tem0)
    if(dimsizes(type@months) .eq. 1)
      var  = tem0(:,:,{range(2):range(3)})
      else
      var  = tem0(:,:,:,{range(2):range(3)})
      end if
  else

    if(isLevel)
      var = f[ind_year]->$name(type)$(:,type@months-1,{type@level},{range(0):range(1)},{range(2):range(3)})
    else
      var = f[ind_year]->$name(type)$(:,type@months-1,{range(0):range(1)},{range(2):range(3)})
    end if
  end if

  if(isLevel .and. dimsizes(type@level) .eq. 1)
    var@name = opt@names(type)+type@level
    else
    var@name = opt@names(type)
  end if
  copy_VarAtts(type,var)
  var@source = "jra55"
  ; printVarSummary(var)
  if(nyear .ne. 1)
    var!0 = "year"
    var&year = type@year
  end if
  count = 0
  if(nyear .ne. 1)
    var!0 = "year"
    var&year = type@year
    count = 1
  end if

  if(dimsizes(type@months) .ne. 1)
    var!count = "month"
    var&month = type@months
  end if

  return(var)
end

undef("read_ERA5")
  function read_ERA5(type,range,opt)
  begin
  get_path(type)
  ; print("reading begin")
  months = (/"J","F","M","A","M","J","J","A","S","O","N","D","J","F","M","A","M","J","J","A","S","O","N","D","J","F","M","A","M","J","J","A","S","O","N","D"/)
  nyear = dimsizes(type@year)
  ind_year = type@year-1979
  opt@names   := (/"SST","SLP","SAT","U","V","H","T","vv","SIC","SAT","U2m","V2m","pre","OLR","relv","strm","precip"/)
  path = (/"none","slp/SLP.mn.","surf/SAT.mn.",   "u/u.mn.",   "v/v.mn.", "hgt/hgt.mn.","T/T.mn","vv/vv.mn.","none","none","surf/U2m.mn.","surf/V2m.mn.","none","none","relv/relv","strm/strm.mn."/)
  name = (/"none",  "slp",  "SAT","u","v","hgt","T","vv","none","none","U2m","V2m","none","none","relv","strm"/)
  if(path(type) .eq. "none")
    print("--------------------------")
    print("Is the source (ERA5) set correct?")
    print("--------------------------")
    exit
  end if
  files = systemfunc("ls "+readpath(0)+"ERA5/"+path(type)+"*.nc")
  f = addfiles(files, "r") 
  ListSetType(f, "join")  
  isLevel  = isfilevarcoord(f[0], name(type), "level");判断变量是否有层次信息
  if(range(2) .lt. 0)
    if(isLevel)
      tem = f[ind_year]->$name(type)$(:,type@months-1,{type@level},{range(0):range(1)},:)
    else
      tem = f[ind_year]->$name(type)$(:,type@months-1,{range(0):range(1)},:)
    end if
    tem0 = lonPivot(tem, range(2)+360)
    var  = tem0(:,:,{range(2):range(3)})
  else
    if(isLevel)
      var = f[ind_year]->$name(type)$(:,type@months-1,{type@level},{range(0):range(1)},{range(2):range(3)})
    else
      var = f[ind_year]->$name(type)$(:,type@months-1,{range(0):range(1)},{range(2):range(3)})
    end if
  end if
  if(isLevel .and. dimsizes(type@level) .eq. 1)
    var@name = opt@names(type)+type@level
    else
    var@name = opt@names(type)
  end if
  copy_VarAtts(type,var)
  var@source = "ERA5"
  ; printVarSummary(var)
  count = 0
  if(nyear .ne. 1)
    var!0 = "year"
    var&year = type@year
    count = 1
  end if

  if(dimsizes(type@months) .ne. 1)
    var!count = "month"
    var&month = type@months
  end if
  if(type .eq. 5) var = (/var/9.8/) end if
  ; printVarSummary(var)
  return(var)
end

undef("read_ncep")
  function read_ncep (type,range,opt)
  begin
  get_path(type)
  name     = (/"none","slp","none","uwnd","vwnd","hgt","air","omega","none","none"/)
  f        = addfile (type@path+".mon.mean.nc", "r")
  time     = cd_calendar(f->time, -1)
  ; time_ind = ind(time .ge. t(0)*100+1 .and. time .le. t(1)*100+12)

  ; dims     = dimsizes(f->$name(type)$)
  isLevel  = isfilevarcoord(f, name(type), "level");判断文件是否有层次信息

  utc_date = cd_calendar(f->time, 0)
  year     = floattointeger(utc_date(:,0))
  month    = floattointeger(utc_date(:,1))
  mon_ind = ind(year .ge. min(type@year) .and. year .le. max(type@year) .and. (month .ge. min(type@months) .and. month .le. max(type@months))) 
    
  if(range(2) .lt. 0)
    if(isLevel)
      tem = f->$name(type)$(mon_ind,{type@level},{range(0):range(1)},:)
    else
      tem = f->$name(type)$(mon_ind,{range(0):range(1)},:)
      type@level :=""
    end if
      tem0 = lonflip(tem)
      ; tem0 = lonPivot(tem, range(2)+360)
      tem := tem0(:,:,{range(2):range(3)})
  else
    if(isLevel)
      tem = f->$name(type)$(mon_ind,{type@level},{range(0):range(1)},{range(2):range(3)})
      else
      tem = f->$name(type)$(mon_ind,{range(0):range(1)},{range(2):range(3)})
      type@level := ""
    end if
  end if
  ; printVarSummary(tem)
  dims := dimsizes(tem)
  isLevel = iscoord(tem,"level")
  if(dimsizes(type@months) .eq. 1)
    if(isLevel)
      var = reshape(tem,(/dimsizes(type@year),dimsizes(type@level),dims(2),dims(3)/))
      var!1 = "level"
      copy_VarCoords(tem(0,:,:), var(0,0,:,:))
    else
      var = tem
    end if 
  else
    if(isLevel)
      var = reshape(tem,(/dimsizes(type@year),dimsizes(type@months),dimsizes(type@level),dims(2),dims(3)/))
      var!2 = "level"
      copy_VarCoords(tem(0,:,:), var(0,0,0,:,:))
    else
      var = reshape(tem,(/dimsizes(type@year),dimsizes(type@months),dims(1),dims(2)/))
      copy_VarCoords(tem(0,:,:), var(0,0,:,:))
    end if
    var!1 = "month"
  end if
  
  ; if(isLevel)
  ;   var = reshape(tem,(/dimsizes(type@year),dimsizes(type@months),dimsizes(type@level),dims(2),dims(3)/))
  ;   var!2 = "level"
  ; else
  ;   var = reshape(tem, (/dimsizes(type@year),dimsizes(type@months),dims(1),dims(2)/))
  ; end if
  var!0 = "year"
  var&year = type@year
  return(var)
end


undef("read_CMIP6")
  function read_CMIP6(type,range,opt)
  begin
  path = readpath(2)+"CMIP6/"
  print("---------------------------")
  print("present model: "+type@model)
  print("Only uwind now")
  print("---------------------------")
  type = 3;目前只有u风场
  model = type@model
  run = type@run
  files = systemfunc("ls "+path+model+"/"+run+"/ua_all_mon_"+model+"_"+run+"*.nc")
  f = addfiles(files,"r")
  utc_date = cd_calendar(f[0]->time, 0)
  year     = floattointeger(utc_date(:,0))
  month    = floattointeger(utc_date(:,1))

  mon_ind = ind(year .ge. min(type@year) .and. year .le. max(type@year) .and. (month .ge. min(type@months) .and. month .le. max(type@months))) 
  ; time = cd_calendar(f[0]->time,-1)
  ; utc_date = 
  ; year_start = time/100
  ; year0 = conform_dims((/dimsizes(type@year),dimsizes(type@months)/),(type@year-year_start)*12,0)
  ; month = year0+conform_dims((/dimsizes(type@year),dimsizes(type@months)/),type@months-1,1)
  ; mon = ndtooned(month)
  ; print(time)
  ; return(0)
  u  = f[:]->ua(mon_ind,{type@level},{range(0):range(1)},{range(2):range(3)})
  dim = dimsizes(u)
  nyear = dimsizes(type@year)
  u_re = reshape(u,(/nyear,dim(0)/nyear,dim(1),dim(2)/))
  u_re!0 = "year"
  u_re&year = type@year
  u_re!1 = "month"
  u_re&month = type@months
  u_re@name = "U"+type@level
  copy_VarCoords(u(0,:,:),u_re(0,0,:,:))
  return(u_re)
  end


undef("readata")
  function readata(type,range,opt)
  begin
  ; printVarSummary(type)
  type@preyear = get_res_value_keep(type,"preyear",False)
  type@posyear = get_res_value_keep(type,"posyear",False)
  opt@detrend  = get_res_value_keep(opt,"detrend",False)
  type@year = type@year - where(type@preyear,1,0) + where(type@posyear,1,0)
  t = (/min(type@year),max(type@year)/) 
  if(max(type@months) .gt. 12) t(1) = t(1)+1 end if
  if(max(type@months) .gt. 24) t(1) = t(1)+1 end if
  localpath = readpath(0)
  opt@names   := (/"SST","SLP","SAT","U","V","H","T","vv","SIC","SAT","U2m","V2m","pre","OLR","relv","strm","precip"/)
  print("reading begin")
  
  ; if(type .eq. 14 ) type@source = "JRA55" end if
  if(type .eq. 12 .or. type .eq. 0 .or. type .eq. 8 .or. type .eq. 16 .or. type .eq. 9) type@source = "GPCP" end if
  months = (/"J","F","M","A","M","J","J","A","S","O","N","D","J","F","M","A","M","J","J","A","S","O","N","D","J","F","M","A","M","J","J","A","S","O","N","D"/)
  nyear = dimsizes(type@year)

  if(type .eq. 12 .and. t(0) .le. 1978) 
    t(0) = 1979
    print("the start year of GPCP precip is changed to 1979")
  end if
  ; if(opt@season .eq. "DJF" .or. opt@season .eq. "NDJ") 
  ; nyear = nyear+1
  ; t(0)  = t(0)-1
  ; end if
  
  ind_months = conform_dims((/dimsizes(type@year),dimsizes(type@months)/),ispan(0,dimsizes(type@year)*12-12,12),0)+conform_dims((/dimsizes(type@year),dimsizes(type@months)/),type@months-1,1)
  mon = ndtooned(ind_months)
  

if(type@source .eq. "ERA-I")
    path     = (/"none","SLP","T2","U-level","V-level","H-level","air","W-level"/)
    name     = (/"sst","slp","T2mSST_anomaly","u","v","z","air","omega","sic"/)
    f        = addfile (localpath+"ERA-I/ERA-I-"+path(type)+"-79-1703.nc", "r")
    time     = cd_calendar(f->time, -1)
    isLevel = isfilevarcoord(f,name(type),"level")
    ; print(time)
    ; time_ind = ind(time .ge. range(4)-100 .and. time .le. range(5))
    time_ind = ind(time .ge. t(0)*100+1 .and. time .le. t(1)*100+12)
    
    
    if(isLevel)then
      tem0 = short2flt(f->$name(type)$(time_ind,{type@level},:,:))
      else
      tem0 = short2flt(f->$name(type)$(time_ind,:,:))
      end if
      tem0!1 = "lat"
      tem0!2 = "lon"
    if(isatt(opt, "lonP0") .and. opt@lonP0)then
      tem1 = lonPivot(tem0, 0.5)
      tem0 = tem1
    end if

    if(type .eq. 5)  tem0 = (/tem0/9.8/) end if
    ab = cd_calendar(tem0&time, -1)
    delete(tem0&time)
    tem0&time = ab
    var = tem0(:,{range(0):range(1)},{range(2):range(3)})
  else if(type@source .eq. "GPCP");GPCP的降水和cobe-2的海温
    if(type .eq. 0 .or. type .eq. 8 .or. type .ge. 12 .or. type .eq. 9)
      path = (/"HANO_SSTV5","slp","CMST","uwnd","vwnd","hgt","air","omega","HadISST.2.2_ice","air","none","none","precip","olr","relv","strm","precipl"/)
      if(type .eq. 8)
        f = addfile(localpath+"GPCP/HadISST.2.2_ice.nc", "r")
      else
        f= addfile(localpath+"GPCP/"+path(type)+".mon.mean.nc", "r")
      end if
      name = (/"SST","slp","CMST","uwnd","vwnd","hgt","air","omega","sic","air","none","none","precip","olr","relv","strm","precip"/)
      ; print(f)
      if(type .eq. 0)
        time = f->time
      else
        time = cd_calendar(f->time, -1)
      end if
      ; print(time)
      ; type@level := ""
      time_ind = ind(time .ge. t(0)*100+1 .and. time .le. t(1)*100+12)
      mon      = time_ind(0)+mon
      if(range(2) .lt. 0)
        tem = f->$name(type)$(mon,{range(0):range(1)},:)
        if(type .eq. 0)
        lon = ispan(0,358,2)*1. 
        lon@units = "degrees_east"
        tem&lon := lon
        end if
        tem0 = lonPivot(tem, range(2)+360)
        tem := tem0(:,:,{range(2):range(3)})
      else
        tem = f->$name(type)$(mon,{range(0):range(1)},{range(2):range(3)})
      end if
      dim = dimsizes(tem)
      if(dimsizes(type@months) .eq. 1)
        var = tem
      else
        var = reshape(tem,(/nyear,dim(0)/nyear,dim(1),dim(2)/))
        copy_VarCoords(tem(0,:,:),var(0,0,:,:))
        ; var!0 = "year"
        ; var!1 = "month"
        ; var&month = type@months
        ; var&year = type@year
        ; var := var({year|:},{month|:},{lat|:},{lon|:})
      end if
      var@name = opt@names(type)
    else
      print("--------------------------")
      print("Is the source (GPCP) set correct?")
      print("--------------------------")
      exit
    end if
  end if
  end if
  ; if(iscoord(var, "time")) var&time = cd_calendar(var&time,-1) end if
  var@type     = type
  var@months   = type@months
  var@detrend  = opt@detrend
  var@mon_name = ""
  return(var)
end

undef("predata")
  function predata(type,range,opt)
  local tem,var,var_dt,path,a,var0,res,f
  begin 
  if(type .eq. 0);读取海温数据
    var = read_SST(type,range,opt)
  else if(type .eq. 12);读取降水数据
    var = read_precip(type,range,opt)
  else if(type@source .eq. "JRA55" .or. type@source .eq. "jra55")
    var = read_jra55(type,range,opt)
  else if(type@source .eq. "ERA5")
    var = read_ERA5(type,range,opt)
  else if(type@source .eq. "ncep1" .or. type@source .eq. "ncep2")
    var = read_ncep(type,range,opt)
  else if(type@source .eq. "CMIP6")
    var = read_CMIP6(type,range,opt)
  else
    var = readata(type,range,opt)
  end if
  end if
  end if
  end if
  end if
  end if
  months   = (/"J","F","M","A","M","J","J","A","S","O","N","D","J","F","M","A","M","J","J","A","S","O","N","D","J","F","M","A","M","J","J","A","S","O","N","D"/)
  month    = (/"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"/)
  dim      = dimsizes(var)
  opt@data = get_res_value_keep(opt,"data",1)
  var_name = var@name
  ; printVarSummary(type)

if(dimsizes(type@months) .eq. 1)
  var_c      = dim_avg_n(var,0)
  var_c@name = var_name
  if(opt@data .eq. 0) return(dim_avg_n_Wrap(var, 0)) end if
  var0 = var
  if(get_res_value_keep(opt,"detrend",False)) 
    var0 = (/dtrend_leftdim(var, True)/)
  end if
  ; var_ctemp = conform(var, var_c, (/1,2/))
else
  if(type .eq. 8)
  var!1 = "lat"
  var!2 = "lon"
  end if
  print(type@source)
  ; if(type@source .ne. "jra55" .and. type@source .ne. "ERA5")
    ; var0 := reshape(var,(/dimsizes(type@year),dimsizes(type@months),dimsizes(var&lat),dimsizes(var&lon)/))

  ; else
  var0 := var
  ; end if
  var_c = dim_avg_n_Wrap(var0, 0)
  var_c@name = var_name
  ; 0为气候态
  if(opt@data .eq. 0) return(dim_avg_n_Wrap(var_c, 0)) end if
  if(get_res_value_keep(opt,"detrend",False)) var0 = (/dtrend_n(var0,True,0)/) end if
; var_ctemp = conform(var0, var_c, (/1,2,3/))
end if
  ; 1为距平
  if(opt@data .eq. 1) var0 := dim_rmvmean_n_Wrap(var0, 0) end if
  ; if(opt@data .eq. 1) var0 := (/var0 - var_ctemp/) end if

  ; 2为标准化
  if(opt@data .eq. 2) var0 := dim_standardize_n_Wrap(var0,0, 0) end if
  ; 其他数字则使用原值
  copy_VarAtts(var, var0)
  if(dimsizes(type@months) .eq. 1 ) 
    var0@mon_name = month(type@months-1)
    ; copy_VarCoords(var,var0)
  else
    var0 := dim_avg_n_Wrap(var0, 1) 
    var0@mon_name = ""
    do i = 0,dimsizes(type@months)-1,1
      var0@mon_name = var0@mon_name+months(type@months(i)-1)
    end do
    if(get_res_value_keep(type,"preyear",False))
      var0@mon_name = var0@mon_name+"(-1)"
    end if
    ; if(opt@detrend) var0 := (/dtrend_leftdim(var0, True)/)  end if
    copy_VarCoords(var(:,0,:,:),var0(:,:,:))
  end if
  
  ; printVarSummary(var0)

  var0!0 = "year"
  var0&year := type@year
  var0@name = var_name
    print(var0@mon_name)
    print("reading complete")
  return(var0)
  end

undef("predata_ver")
  function predata_ver(type,range,opt)
  begin 
  print(type@source)
  localpath   = readpath(0)
  opt@data    = get_res_value_keep(opt,"data",1)
  opt@detrend = get_res_value_keep(opt,"detrend",False)
  months      = (/"J","F","M","A","M","J","J","A","S","O","N","D"/)
  month       = (/"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"/)
  pres       = (/1000,975,950,925,900,875,850,825,800,775,750,700,650,600,550,500,450,400,350,300,250,225,200,175,150,125,100/)
  ; opt@names   := (/"SST","SLP","SAT","U","V","H","T","vv","SIC","LAT","U2m","V2m","pre","OLR","relv","strm"/)
  ; print("reading begin")
  nyear = dimsizes(type@year)
  type@level := get_res_value_keep(type,"levels",pres)
  if(type .eq. 0)
    var = read_SST(type,range,opt)
  else if(type@source .eq. "JRA55" .or. type@source .eq. "jra55")
    var = read_jra55(type,range,opt)
  else if(type@source .eq. "ERA5")
    var = read_ERA5(type,range,opt)
  else
    var = readata(type,range,opt)
  end if
  end if
  end if
  ; var      = readata(type,range,opt)

  var_name = opt@names(type)
  ; printVarSummary(var)

if(dimsizes(type@months) .eq. 1)
  var_c = dim_avg_n(var,0)
  var_c@name = var_name
  var0 = var
  if(opt@data .eq. 0) return(dim_avg_n_Wrap(var, 0)) end if
  if(opt@detrend) var = (/dtrend_leftdim(var, True)/) end if
  var_ctemp = conform(var, var_c, (/1,2,3/))

else
  if(type .eq. 8)
  var!2 = "lat"
  var!3 = "lon"
  end if
  var0 := reshape(var,(/dimsizes(type@year),dimsizes(type@months),dimsizes(var&level),dimsizes(var&lat),dimsizes(var&lon)/))
  var_c = dim_avg_n(var0, 0)
  copy_VarCoords(var(0,:,:,:,:),var_c)
  var_c@name = var_name
  if(opt@data .eq. 0) return(dim_avg_n_Wrap(var_c, 0)) end if
  if(opt@detrend) var0 := (/dtrend_leftdim(var0, True)/) end if
  var_ctemp = conform(var0, var_c, (/1,2,3,4/))
end if

  if(opt@data .eq. 1) var0 := (/var0 - var_ctemp/) end if
  if(opt@data .eq. 2) var0 := dim_standardize_n_Wrap(var0,0, 0) end if
  copy_VarAtts(var, var0)
  if(dimsizes(type@months) .eq. 1 ) 
    var0@mon_name = month(type@months-1)
  else
    var0 := dim_avg_n_Wrap(var0, 1) 
    var0@mon_name = ""
    do i = 0,dimsizes(type@months)-1,1
      var0@mon_name = var0@mon_name+months(type@months(i)-1)
    end do
  end if
  copy_VarCoords(var(:,0,:,:,:),var0)

  var0!0 = "year"
  var0&year = type@year
    print("reading complete")
  return(var0)

  ; t = (/min(opt@year),max(opt@year)/)

  ; if(opt@season .eq. "DJF" .or. opt@season .eq. "NDJ") 
  ;   nyear = nyear+1
  ;   t(0) = t(0)-1
  ; end if
  ; year_all = ispan(1958, 2019, 1)
  ; ind_year = ind(year_all .ge. t(0) .and. year_all .le. t(1))
  ;  path = (/"none","surf/SLP.mn.","surf/SAT.mn.",   "u/u.mn.",   "v/v.mn.", "hgt/hgt.mn.","T/T.mn","vv/vv.mn.","none","none","surf/U2m.mn.","surf/V2m.mn.","none","none","relv/relv","strm/strm.mn."/)
  ;   name = (/"none",  "SLP",  "SAT","u","v","hgt","T","vv","none","none","U2m","V2m","none","none","relv","strm"/)
  ;   files = systemfunc("ls "+localpath+"jra55/"+path(type)+"*.nc")
  ; f = addfiles(files, "r") 
  ; ListSetType(f, "join")
  ; type@levels = get_res_value_keep(type,"levels",f[0]->level(::-1))
  ; var = f[ind_year]->$name(type)$(:,opt@months-1,{type@levels},{range(0):range(1)},{range(2):range(3)})
  ; var@name = opt@names(type)
  ; print("reading complete")

  ; var_c = dim_avg_n_Wrap(var, 0)
  ; if(opt@data .eq. 0) return(dim_avg_n_Wrap(var_c, 0)) end if

  ; if(opt@detrend) var = (/dtrend_leftdim(var, True)/) end if

  ; if(dimsizes(type@months) .eq. 1) 
  ;   var_ctemp = conform(var, var_c, (/1,2,3/))
  ;   else 
  ;   var_ctemp = conform(var, var_c, (/1,2,3,4/))
  ; end if

  ; if(opt@data .eq. 1) var = (/var - var_ctemp/) end if
  ; if(opt@data .eq. 2)  var := dim_standardize_n_Wrap(var,0, 0)end if

  ; if(dimsizes(opt@months) .ne. 1 ) var := dim_avg_n_Wrap(var, 1) end if
  ; var@name = var@name+where(opt@detrend, "_dt", "")
  ; var@name = opt@names(type)
  ; var!0 = "year"
  ; var&year = ispan(t(0),t(1),1)
  ; var@months = ""
  ; if(dimsizes(opt@months) .eq. 1)
  ;   months_name = months_full
  ;   else
  ;   months_name = months
  ; end if
  ; do i = 0,dimsizes(opt@months)-1,1
  ;   var@months = var@months+months_name(opt@months(i)-1)
  ; end do
  ; return(var)
  ; if(dimsizes(type@months) .eq. 1 ) 
  ;   var0@mon_name = month(type@months-1)
  ;   ; copy_VarCoords(var,var0)
  ; else
  ;   var0 := dim_avg_n_Wrap(var0, 1) 
  ;   var0@mon_name = ""
  ;   do i = 0,dimsizes(type@months)-1,1
  ;     var0@mon_name = var0@mon_name+months(type@months(i)-1)
  ;   end do
  ;   if(type@preyear .eq. True)
  ;     var0@mon_name = var0@mon_name+"(-1)"
  ;   end if
  ;   printVarSummary(var)
  ;   ; if(opt@detrend) var0 := (/dtrend_leftdim(var0, True)/)  end if
  ;   copy_VarCoords(var(:,0,:,:),var0(:,:,:))
  ; end if
  end