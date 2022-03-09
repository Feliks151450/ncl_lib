undef("printx")
procedure printx(str)
  begin
  print("----------------------------------------------------")
  print(""+str)
  print("----------------------------------------------------")
end



undef("is_element")
function is_element(element[1],array[*])
  begin
  tem = ind(array .eq. element)
  test = .not. isatt(tem,"_FillValue")
  test@ind = tem
  return(test)
end

undef("get_element")
function get_element(element[1],array[*],selection[*])
  begin
  tem = ind(array .eq. element)
  if(isatt(tem,"_FillValue"))
    printx("the element: '"+element+"' is not found in given array")
    test = False
  else
    test = selection(tem)
    test@location = tem
  end if
  return(test)
end

undef("merge")
function merge(var0,var1); 合并的维度必须在最右侧
  begin
  dim0 = dimsizes(var0)
  dim1 = dimsizes(var1)
  dim = dimsizes(dim0)

  dim2 = dim0
  dim2(dim-1) = dim0(dim-1)+dim1(dim-1)
  var = new(dim2,float)
  if(dim .eq. 2)
    var(:,:dim0(1)-1) = var0
    var(:,dim0(1):) = var1
    copy_VarCoords(var0(:,0),var(:,0))
  else if(dim .eq. 3)
    var(:,:,:dim0(2)-1) = var0
    var(:,:,dim0(2):) = var1
    copy_VarCoords(var0(:,:,0),var(:,:,0))
  else if(dim .eq. 4)
    var(:,:,:,:dim0(3)-1) = var0
    var(:,:,:,dim0(3):) = var1
    copy_VarCoords(var0(:,:,:,0),var(:,:,:,0))
  else if(dim .eq. 5)
    var(:,:,:,:,:dim0(4)-1) = var0
    var(:,:,:,:,dim0(4):) = var1
    copy_VarCoords(var0(:,:,:,:,0),var(:,:,:,:,0))
  end if
  end if
  end if
  end if
  return(var)
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
    return(var)
  end if
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

  range(2:) = range(2:)-where(range(2) .ge. centerLon+180,360,0)
  range(2:) = range(2:)+where(range(3) .le. centerLon-180,360,0)
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

undef("setNatureMode")
procedure setNatureMode (res)
  begin
  res@gsnLeftString = ""
  res@gsnRightString = ""
  res@gsnStringBold = True
  res@gsnLeftStringFontHeightF = 0.04
  res@tiYAxisOffsetXF = 0.025
end

undef("setLabelbarTitle");FX| 设置色标标题
  procedure setLabelbarTitle (res)
  begin
  res@lbTitleOn = True
  res@lbTitleExtentF = 0.2
  res@lbOrientation       = get_res_value_keep(res,"lbOrientation","Horizontal")
  if(.not. isatt(res,"lbTitleFontHeightF"))
    res@lbTitleFontHeightF = res@lbLabelFontHeightF
  end if
  if(.not. isatt(res,"lbTitleOffsetF"))
    res@lbTitleOffsetF = 0.2
  end if
  if(res@lbOrientation .eq. "Vertical")
    res@lbTitlePosition = "right"
    res@lbTitleDirection = "across"
    res@lbTitleAngleF = 270
  else
    res@lbTitlePosition = "bottom"
    res@lbTitleDirection = "across"
  end if
end

undef("setLabelbar");FX| 设置色标
procedure setLabelbar (res)
  begin
      ; resp@lbOrientation = "Horizontal"
  res@lbBoxLineColor = "white"
  res@lbBoxLineThicknessF = 25
  res@lbLabelFontHeightF = 0.016
    ; res@gsnPanelScalePlotIndex = 2
  res@lbBoxEndCapStyle = "TriangleBothEnds"
    ; ; resp@gsnFrame = False
    ; ; resp@gsnPanelLeft = 0.1
    ; ; resp@gsnPanelRight = 0.1
    ; ; resp@gsnPanelTop = 1.1
    ; ; resp@gsnPanelYWhiteSpacePercent = 16.0
    ; resp@gsnPanelXWhiteSpacePercent = 5
    ; ; resp@gsnMaximize = False
    ; if(resp@lbOrientation .eq. "Vertical")
    ;     resp@pmLabelBarWidthF = 0.13
    ;     resp@pmLabelBarHeightF = 0.9
    ;     resp@gsnPanelBottom = 0.07
    ;     resp@pmLabelBarParallelPosF = -0.022
    ;     resp@gsnPanelYWhiteSpacePercent = 2.0
    ;     else 
    ;     resp@pmLabelBarHeightF = 0.09
    ;     resp@pmLabelBarWidthF = 0.85
    ;     resp@gsnPanelLeft = 0.01
    ;     resp@gsnPanelRight = 0.99
    ;     resp@pmLabelBarOrthogonalPosF = 0.026
    ;     resp@pmLabelBarParallelPosF = 0.002
    ;     resp@gsnPanelYWhiteSpacePercent = 6.0
    ; end if
end