undef("readpath")
function readpath(type)
begin
  path = (/"/Users/linlifei/data/",\
          "/Users/linlifei/desktop/",\
          "/Volumes/HHD/"/)
return(path(type)) 
end

undef("md_print")
procedure md_print(var,opt)
  begin
  f = "~/LLF/ncl/var.md"
  header = (/"# Var: "+var@name,systemfunc("date"),"|type|value|size|","|----|----|----|"/)
  alist = [/header/]
  ;if(get_res_value_keep(opt,"overWrite",True))
  if(opt)
    write_table(f, "w", alist, "%s")
  else
    write_table(f, "a", alist, "%s")
  end if
  var_name = "|"+var@name
  type = "|"+typeof(var)
  dim = dimsizes(var)
  if(dimsizes(dim) .eq. 1 .and. dim .eq. 1)
    str = var+"|"
  else
    str = "array|"
  end if
  value = "|"+str
  dim_info = oneDtostring(dim)+"|"
  alist := [/type+value+dim_info/]
  write_table(f, "a", alist, "%s")

  dim_name = getvardimnames(var)
  if(.not. any(ismissing(dim_name)))
    header := (/"","|dim|size|value|","|----|----|----|"/)
    write_table(f, "a", [/header/], "%s")
    dim_value = new(dimsizes(dim_name),string)
    do i = 0, dimsizes(dim_name)-1
      dim_value(i) = oneDtostring(var&$dim_name(i)$)
    end do
    alist := [/"|"+dim_name+"|"+dim+"|"+dim_value+"|"/]
    write_table(f, "a", alist, "%s")
  end if

  header := (/"","|atts|value|","|----|----|"/)
  alist = [/header/]
  write_table(f, "a", alist, "%s")
  atts_name = getvaratts(var)
  atts_value = atts_name
  do i = 0, dimsizes(atts_name)-1
    if(dimsizes(var@$atts_name(i)$) .eq. 1)
      atts_value(i) = var@$atts_name(i)$
    else 
      atts_value(i) = oneDtostring(var@$atts_name(i)$)
    end if
  end do
  alist := [/"|"+atts_name(::-1)+"|"+atts_value(::-1)+"|"/]
  write_table(f, "a", alist, "%s")


end

undef("get_path")
  procedure get_path(type)
  begin
  ; 对应海温，降水，jra55，era5，ncep资料存放目录
  folder = (/"~/data/SST/","~/data/precip/","~/data/jra55/","~/data/ERA5/","~/data/ncep"/)
  if(type .eq. 0);读取海温数据配置
    ; 不同海温资料
    sources   = (/  "combined",    "HadISST","ERSSTv3","ERSSTv4","ERSSTv5","COBE","COBE2","OISST","Kaplan"/)
    ; nc文件里的变量名
    var_name  = (/       "SST",        "sst","sst","sst","sst","sst","sst","sst"/)
    ; 文件名
    file_name = (/"HANO_SSTV5","HadISST_sst","ERSST.v3","ERSST.v4","ERSST.v5","COBE","COBE2","OISST","Kaplan"/)
    messages =(/"averaging ERSSTv5 & HadISST","HadISST","ERSSTv3","ERSSTv4","ERSSTv5","COBE","COBE2","OISST","Kaplan"/) 
    type@source = get_res_value_keep(type,"source","combined")
    ind_file = is_element(type@source,sources)
    if(ind_file)
      type@file_path = folder(0)+file_names(ind_file@ind)+".mon.mean.nc"
      if(.not. isfilepresent(type@file_path))
        printx("this file dose not exist: "+type@file_path)
        exit
      end if
      type@var = var_names(ind_file@ind)
      printx("using the SST data: "+messages(ind_file@ind))
    else
      printx("is the source "+type@source+" correct for SST data?")
      exit
    end if
  else if(type .eq. 12);读取降水数据配置
    ; 不同海温资料
    source = (/"combined","GPCP","NOAA Land"/)
    ; nc文件里的变量名
    var_name = (/"pre","precip","precip"/)
    ; 文件
    file_name = (/"GPCP-NOAA-79-2101","precip.mon.mean","precipl.mon.mean"/)
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