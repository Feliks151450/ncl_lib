undef("readpath")
function readpath(type)
begin
  path = (/"/Users/linlifei/data/",\
          "/Users/linlifei/",\
          "/Volumes/data/"/)
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