; 说明文档：https://www.craft.do/s/GYIYbC0iW53gbL

undef("get_path")
  procedure get_path(type)
  begin
  if(typeof(type) .eq. "string")
    type_list = (/"SST","SLP","SAT","U","V","H","T","vv","SIC","SAT","U2m","V2m","pre","OLR","relv","strm","precip","reld","vpot","q","sp"/)
    var_ind = get_element(type,type_list,ispan(0,dimsizes(type_list)-1,1))
  else var_ind = type
  end if
  ; 对应海温，降水，jra55，era5，ncep资料存放目录
  folder = (/"SST/","precip/","jra55/","~/data/ERA5/","~/data/ncep"/)
  if(var_ind .eq. 0);读取海温数据配置
    ; 不同海温资料
    sources   = (/  "combined",    "HadISST","ERSSTv3","ERSSTv4","ERSSTv5","COBE","COBE2","OISST","Kaplan"/)
    ; 文件名
    file_name = (/"HANO_SSTV5","HadISST_sst","ERSST.v3","ERSST.v4","ERSST.v5","COBE","COBE2","OISST","Kaplan"/)
    messages =(/"averaging ERSSTv5 & HadISST","HadISST","ERSSTv3","ERSSTv4","ERSSTv5","COBE","COBE2","OISST","Kaplan"/) 
    type@source = get_res_value_keep(type,"source","combined")
    ind_file = is_element(type@source,sources)
    if(ind_file)
      type@file_path = readpath(0)+folder(0)+file_name(ind_file@ind)+".mon.mean.nc"
      if(.not. isfilepresent(type@file_path))
        printx("this file dose not exist: "+type@file_path)
        exit
      end if
      type@var = "sst"
      printx("using the SST data: "+messages(ind_file@ind))
    else
      printx("is the source "+type@source+" correct for SST data?")
      exit
    end if
  else if(var_ind .eq. 12);读取降水数据配置
    ; 不同海温资料
    source = (/"combined","GPCP","NOAA Land"/)
    ; nc文件里的变量名
    var_name = (/"pre","precip","precip"/)
    ; 文件
    file_name = (/"GPCP-NOAA.mon.mean","precip.mon.mean","precip.mon.mean.0.5x0.5"/)
    message =(/"averaging NOAA Land and GPCP","GPCP","NOAA Land"/) 
    type@source = get_res_value_keep(type,"source","combined")
    ind_file = is_element(type@source,source)
    if(ind_file)
      type@file_path = folder(1)+file_names(ind_file@ind)+".mon.mean.nc"
      if(.not. isfilepresent(type@file_path))
        printx("this file dose not exist: "+type@file_path)
        exit
      end if
      type@var = var_names(ind_file@ind)
      printx("using the rainfall data: "+messages(ind_file@ind))
    else
      printx("is the source "+type@source+" correct for rainfall data?")
      exit
    end if
  else if(type@source .eq. "JRA55" .or. type@source .eq. "jra55")
    path = (/"none","surf/SLP","surf/SAT","u/u","v/v", "hgt/hgt/","T/T/","vv/vv/","none","none","surf/U2m","surf/V2m","none","none","relv/relv","strm/strm","none","reld/reld","vpot/vpot","q/spfh","surf/SP"/)
    if(path(type) .eq. "none")
      printx("Is the source (JRA55) set correct?")
      exit
    end if
    type@path = folder(2)+path(type)
  else if(type@source .eq. "ERA5")
    path = (/"none","slp/SLP.mn.","surf/SAT.mn.",   "u/u.mn.",   "v/v.mn.", "hgt/hgt.mn.","T/T.mn","vv/vv.mn.","none","none","surf/U2m.mn.","surf/V2m.mn.","none","none","relv/relv","strm/strm.mn."/)
    if(path(type) .eq. "none")
      printx("Is the source (ERA5) set correct?")
      exit
    end if
    type@path = folder(3)+path(type)
  else if(type@source .eq. "ncep1" .or. type@source .eq. "ncep2")
    path     = (/"none","slp","none","uwnd","vwnd","hgt","air","omega","none","none"/)
    if(name(type) .eq. "none")
      printx("is the type '"+type+"' correct for "+folder+" ?")
      exit
    end if
    type@path = folder(4)+type@source+"/"+path(type)
  else if(type@source .eq. "CMIP6")
  end if
  end if
  end if
  end if
  end if
  end if
; pwd = systemfunc("pwd")
; print(pwd)
; ls = systemfunc("ls")
; test = is_element("data",ls)
; if (test)
;   data = pwd+"/data"
; else
;   sub_ind = str_index_of_substr(pwd, "/", -1)
;   sub = str_split_by_length(pwd, sub_ind)
;   ls := systemfunc("ls "+sub(0))
;   test = is_element("data",ls)
;   if (test) 
;   data = sub(0) + "/data"
;   end if
; end if
end

undef("read_from_file")
function read_from_file(f,type,var_name,range,res)
  begin
  if(range(2) .gt. range(3))
    printx("wrong range!")
    exit
  end if
  isLevel = isfilevar(f,"level")
  if(isLevel .and. dimsizes(type@level) .ne. 1)
    printx("you should specify only one level, or use the resources: levels")
    exit
  end if
  lon = f->lon
  centerLon = where(min(lon)*max(lon) .ge. 0, 180, 0)
  ; print(f)
  utc_date = cd_calendar(f->time, 0)
  year     = floattointeger(utc_date(:,0))
  month    = floattointeger(utc_date(:,1))
  mon_ind = ind(year .ge. min(type@year) .and. year .le. max(type@year) .and. (month .ge. min(type@months) .and. month .le. max(type@months))) 

  range(2:) = range(2:)-where(range(2) .ge. centerLon+180,360,0)
  range(2:) = range(2:)+where(range(3) .le. centerLon-180,360,0)

  if(range(2) .ge. centerLon-180 .and. range(3) .le. centerLon+180);该情况不用分开读取
    if(isLevel)
      level = get_res_value_keep(type,"levels",type@level)
      var = f->$var_name$(mon_ind,{level},{range(0):range(1)},{range(2):range(3)})
    else
      var = f->$var_name$(mon_ind,{range(0):range(1)},{range(2):range(3)})
    end if
  else
    adjust = where(range(2) .lt. centerLon-180,360,0)
    if(isLevel)
      level = get_res_value_keep(type,"levels",type@level)
      tem0 = f->$var_name$(mon_ind,{level},{range(0):range(1)},{range(2)+adjust:centerLon+180})
      tem1 = f->$var_name$(mon_ind,{level},{range(0):range(1)},{centerLon-180:range(3)-(360-adjust)})
    else
      tem0 = f->$var_name$(mon_ind,{range(0):range(1)},{range(2)+adjust:centerLon+180})
      tem1 = f->$var_name$(mon_ind,{range(0):range(1)},{centerLon-180:range(3)-(360-adjust)})
    end if
    lon3 = new((/3,dimsizes(lon)/),float)
    lon_ind = ind(lon3 .ge. range(2) .and. lon3 .le. range(3))
    var_lon = lon3(lon_ind)
    copy_VarAtts(lon,var_lon)
    var = merge(tem0,tem1)
    dim_lon = dimsizes(dimsizes(var))-1
    var!dim_lon = "lon"
    var&lon = var_lon
  end if
  return(var)
end

undef("read_from_files")
function read_from_files(f,type,var_name,range,res)
  begin
  if(range(2) .gt. range(3))
    printx("wrong range!")
    exit
  end if
  isLevel = isfilevar(f[0],"level")
  if(isLevel .and. dimsizes(type@level) .ne. 1)
    printx("you should specify only one level, or use the resources: levels")
    exit
  end if
  lon = f[0]->lon
  centerLon = where(min(lon)*max(lon) .ge. 0, 180, 0)
  ; printx(centerLon)
  range(2:) = range(2:)-where(range(2) .ge. centerLon+180,360,0)
  range(2:) = range(2:)+where(range(3) .le. centerLon-180,360,0)
  ; printx(range)
  if(range(2) .ge. centerLon-180 .and. range(3) .le. centerLon+180);该情况不用分开读取
    if(isLevel)
      level = get_res_value_keep(type,"levels",type@level)
      var = f[res@ind_year]->$var_name$(:,type@months-1,{level},{range(0):range(1)},{range(2):range(3)})
    else
      var = f[res@ind_year]->$var_name$(:,type@months-1,{range(0):range(1)},{range(2):range(3)})
    end if
  else
    adjust = where(range(2) .lt. centerLon-180,360,0)
    if(isLevel)
      level = get_res_value_keep(type,"levels",type@level)
      tem0 = f[res@ind_year]->$var_name$(:,type@months-1,{level},{range(0):range(1)},{range(2)+adjust:centerLon+180})
      tem1 = f[res@ind_year]->$var_name$(:,type@months-1,{level},{range(0):range(1)},{centerLon-180:range(3)-(360-adjust)})
    else
      tem0 = f[res@ind_year]->$var_name$(:,type@months-1,{range(0):range(1)},{range(2)+adjust:centerLon+180})
      tem1 = f[res@ind_year]->$var_name$(:,type@months-1,{range(0):range(1)},{centerLon-180:range(3)-(360-adjust)})
    end if
    lon3 = new(3*dimsizes(lon),float)
    lon3(:dimsizes(lon)-1) = lon-360
    lon3(dimsizes(lon):2*dimsizes(lon)-1) = lon
    lon3(2*dimsizes(lon):3*dimsizes(lon)-1) = lon+360
    lon_ind = ind(lon3 .ge. range(2) .and. lon3 .le. range(3))
    var_lon = lon3(lon_ind)
    copy_VarAtts(lon,var_lon)
    var = merge(tem0,tem1)
    dim_lon = dimsizes(dimsizes(var))-1
    var!dim_lon = "lon"

    var&lon = var_lon
    copy_VarAtts(type,var)
  end if
  return(var)
end

undef("readata")
  function readata(type,opt)
  begin
  month    = (/"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"/)
  get_path(type)
  f = addfile(type@file_path,"r")
  tem = read_from_file(f,type,type@var,type@range,opt)
  dim = dimsizes(tem)
  nyear = dimsizes(type@year)
  if(dimsizes(type@months) .eq. 1)
    var = tem
    var@mon_name = month(type@months-1)
    ; var!1 = "lat"
    ; var!2 = "lon"
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
    var@mon_name = ""
    do i = min(var&month),max(var&month),1
      tem := str_split_by_length(month(i-1),1)
      var@mon_name = var@mon_name+tem(0)
    end do
  end if
  var@month = month(type@months-1)
  var@name = type@var
  return(var)
end

undef("process")
  function process(type,opt)
  begin
  var = readata(type,opt)
  dim      = dimsizes(var)
  ;methods = (/"clim","anom","std"/)
  opt@method = get_res_value_keep(opt,"method","anom")
  print("methond: "+opt@method)
  var_name = var@name
  ; printVarSummary(type)
  isVarMonth = isdim(var, "month")
  if(.not. isVarMonth);处理气候态和去趋势部分
    var_c      = dim_avg_n_Wrap(var,0)
    if(opt@method .eq. "clim") return(var_c) end if
  else
    var_c = dim_avg_n_Wrap(var, 0)
    ; 0为气候态
    if(opt@method .eq. "clim")  
      return(dim_avg_n_Wrap(var, (/0,1/)))
    end if
  end if

  ;去趋势
  if(get_res_value_keep(opt,"detrend",False)) 
    var = (/dtrend_leftdim((/var/), True)/)
  end if

  if(opt@method .eq. "anom") 
    var := dim_rmvmean_n_Wrap(var, 0) 
  end if

  if(opt@method .eq. "std") 
    var := dim_standardize_n_Wrap(var,0, 0) 
  end if

  if(isVarMonth) var := dim_avg_n_Wrap(var, 1) end if
  
  ; var0!0 = "year"
  ; var0&year := type@year
  ; var0@name = var_name
    ; print(var0@mon_name)
    print("reading complete")
  return(var)
end