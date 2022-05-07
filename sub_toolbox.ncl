

undef("printx")
procedure printx(str)
  begin
  print("----------------------------------------------------")
  print(""+str)
  print("----------------------------------------------------")
end

undef("designal") ; FX| designal
  function designal(ts0,ts1)
  begin
  rec=regline(ts1, ts0)
  ts=ts0-rec*ts1
  copy_VarCoords(ts0, ts)
  ts@name = ts0@name+"-"+ts1@name
  return(ts)
end

undef("smart_notify")
procedure smart_notify(wks,ts,type,opt)
  begin
  print("----------------------------------------------------")
  print("in wks: "+wks@name)
  print("----------------------------------------------------")
end

undef("setDefaultAtt")
procedure setDefaultAtt(res, att:string, default)
begin
  if(isatt(res,att)) return(0) end if
  if(typeof(default) .eq. "list")
    list_size = ListCount(default)
    do i = 0, list_size-1, 1
      var := default[i]
      if(any(ismissing(var))) continue
      else 
        res@$att$ = var
        break
      end if
    end do
  else
    res@$att$ = default
  end if
end

undef("setDefaultAtts")
procedure setDefaultAtts(res:logical, atts[*]:string, defaults:list)
begin
  if(dimsizes(atts) .ne. ListCount(defaults))
    print("size of atts must equal to defaults")
    return(0)
  end if
  list_size = ListCount(defaults)
  do i = 0, list_size-1, 1
    if(isatt(res,atts(i))) 
      continue
    else 
      res@$atts(i)$ =defaults[i]
    end if
  end do
end

undef("setExistAtt")
procedure setExistAtt(res:logical, att:string, default)
begin
  if(.not. isatt(res,att)) return(0) end if
  if(typeof(default) .eq. "list")
    list_size = ListCount(default)
    do i = 0, list_size-1, 1
      var := default[i]
      if(ismissing(var))
        continue
      else 
        res@$att$ := var
        break
      end if
    end do
  else
    res@$att$ := default
  end if
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



undef("setNatureMode")
procedure setNatureMode (res)
  begin
  res@gsnLeftString = ""
  res@gsnRightString = ""
  res@gsnStringBold = True
  res@gsnLeftStringFontHeightF = get_res_value_keep(res,"gsnLeftStringFontHeightF", 0.025)
  res@tiYAxisOffsetXF = get_res_value_keep(res,"tiYAxisOffsetXF", 0.025)
end

undef("setLabelbarTitle");FX| 设置色标标题
  procedure setLabelbarTitle (res,title)
  begin
  res@lbTitleString = title
  res@lbTitleOn = True
  res@lbTitleExtentF = 0.2
  ; res@lbOrientation       = get_res_value_keep(res,"lbOrientation","Horizontal")
  setDefaultAtt(res,"lbOrientation","Horizontal")
  ; if(.not. isatt(res,"lbTitleFontHeightF"))
  ;   res@lbTitleFontHeightF = res@lbLabelFontHeightF
  ; end if
  setDefaultAtt(res,"lbTitleFontHeightF",res@lbLabelFontHeightF)
  ; if(.not. isatt(res,"lbTitleOffsetF"))
  ;   res@lbTitleOffsetF = 0.2
  ; end if
  setDefaultAtt(res,"lbTitleOffsetF",0.2)
  if(res@lbOrientation .eq. "Vertical")
    ; res@lbTitlePosition = get_res_value_keep(res,"lbTitlePosition","right")
    setDefaultAtt(res,"lbTitlePosition","right")
    res@lbTitleDirection = "across"
    res@lbTitleAngleF = 270
  else
    ; res@lbTitlePosition = get_res_value_keep(res,"lbTitlePosition","bottom")
    setDefaultAtt(res,"lbTitlePosition","bottom")
    res@lbTitleDirection = "across"
    res@lbTitleAngleF = 0
    ; res@pmLabelBarOrthogonalPosF = res@pmLabelBarOrthogonalPosF+0.1
    if(res@lbTitlePosition .eq. "right")
      res@lbTitleExtentF = 0.01
      res@lbTitleOffsetF = 0.1
      ; res@pmLabelBarOrthogonalPosF = res@pmLabelBarOrthogonalPosF-0.1
    end if
    if(res@lbTitlePosition .eq. "left")
      res@lbTitleExtentF = 0.1
      res@lbTitleOffsetF = 0.1
    end if
  end if
end

undef("setLabelbar");FX| 设置色标
procedure setLabelbar (res)
  begin
      ; resp@lbOrientation = "Horizontal"
  res@lbLabelBarOn        = True
  res@lbBoxLineColor = "black"; "white"
  setDefaultAtt(res,"lbBoxLineThicknessF",[/res@tmBorderThicknessF,1/])

  res@lbLabelFontHeightF  = get_res_value_keep(res,"lbLabelFontHeightF",0.03)
  ; res@lbBoxEndCapStyle    = "" ;get_res_value_keep(res,"lbStyle","TriangleBothEnds")
  res@lbOrientation       = get_res_value_keep(res,"lbOrientation","Horizontal")
  res@lbBoxEndCapStyle = "RectangleEnds"
end

undef("sin_dg")
function sin_dg(degree)
  begin
  result = sin(degree*get_d2r("float"))
  ; result = sin(degree/180.0*get_pi("float"))
  return(result)
end

undef("cos_dg")
function cos_dg(degree)
  begin
  result = cos(degree*get_d2r("float"))
  ; result = cos(degree/180.0*get_pi("float"))
  return(result)
end

undef("add_YRAxisString") ; FX| add_YRAxisString
procedure add_YRAxisString (plotid,text:string,opt)
  begin
  tmp_wks = NhlGetParentWorkstation(plotid)
    rightaxis_string = create "right_axis" textItemClass tmp_wks
      "txString"      : text
      "txFontHeightF" : get_res_value_keep(opt, "txFontHeightF",0.05)
      "txFontColor"   : get_res_value_keep(opt, "txFontColor","black")
      "txAngleF"      : 270.
    end create

    anno = NhlAddAnnotation(plotid,rightaxis_string)
    
    setvalues anno
      "amZone"          : 3      ; Just outside plot area
      "amJust"          : "centercenter"
      "amSide"          : "right" 
      "amParallelPosF"  : 0.5
      "amOrthogonalPosF": 0.03
      "amResizeNotify"  : True     ; Resize if plot resized.
    end setvalues
  ; return(anno)
end

undef("add_YLAxisString") ; FX| add_YLAxisString
procedure add_YLAxisString (plotid,text:string,opt)
  begin
  tmp_wks = NhlGetParentWorkstation(plotid)
    rightaxis_string = create "right_axis" textItemClass tmp_wks
      "txString"      : text
      "txFontHeightF" : get_res_value_keep(opt, "txFontHeightF",0.05)
      "txFontColor"   : get_res_value_keep(opt, "txFontColor","black")
      "txAngleF"      : 90.
    end create

    anno = NhlAddAnnotation(plotid,rightaxis_string)
    
    setvalues anno
      "amZone"          : 3      ; Just outside plot area
      "amJust"          : "centercenter"
      "amSide"          : "left" 
      "amParallelPosF"  : 0.5
      "amOrthogonalPosF": 0.05-get_res_value_keep(opt, "tiYlOffsetXF",0.)
      "amResizeNotify"  : True     ; Resize if plot resized.
    end setvalues
end

undef("add_XBAxisString") ; FX| add_XBAxisString
procedure add_XBAxisString (plotid,text:string,opt)
  begin
  tmp_wks = NhlGetParentWorkstation(plotid)
    rightaxis_string = create "right_axis" textItemClass tmp_wks
      "txString"      : text
      "txFontHeightF" : get_res_value_keep(opt, "txFontHeightF",0.035)
      "txFontColor"   : get_res_value_keep(opt, "txFontColor","black")
      "txAngleF"      : 0.
    end create

    anno = NhlAddAnnotation(plotid,rightaxis_string)
    
    setvalues anno
      "amZone"          : 3      ; Just outside plot area
      "amJust"          : "centercenter"
      "amSide"          : "bottom" 
      "amParallelPosF"  : get_res_value_keep(opt, "tiXBOffsetXF",0.5)
      "amOrthogonalPosF": get_res_value_keep(opt, "tiXBOffsetYF",0.)
      "amResizeNotify"  : True     ; Resize if plot resized.
    end setvalues
end


undef("add_LeftString") ; FX| add_LeftString
procedure add_LeftString (plotid,text:string,opt)
  begin
  tmp_wks = NhlGetParentWorkstation(plotid)
  ; tmp_wks = NhlGetParentWorkstation(tem)
  rightaxis_string = create "right_axis" textItemClass tmp_wks
    "txString"      : text
    "txFontHeightF" : get_res_value_keep(opt, "gsnLeftStringFontHeightF",0.035)
    "txFontColor"   : get_res_value_keep(opt, "txFontColor","black")
    "txAngleF"      : 0.
    "txFont"        : where(get_res_value_keep(opt,"gsnStringBold",False),22,21)
  end create
  anno = NhlAddAnnotation(plotid,rightaxis_string)
    
  setvalues anno
    "amZone"          : 3      ; Just outside plot area
    "amJust"          : "TopLeft"
    "amSide"          : "top" 
    "amParallelPosF"  : get_res_value_keep(opt, "gsnLeftOffsetXF",0.)
    "amOrthogonalPosF": 0.05+get_res_value_keep(opt, "gsnLeftOffsetYF",0.)
    "amResizeNotify"  : True     ; Resize if plot resized.
  end setvalues
end

undef("add_RightString") ; FX| add_RightString
procedure add_RightString (plotid:graphic,text:string,opt)
  begin
  tmp_wks = NhlGetParentWorkstation(plotid)
  RightString = create "RightString" textItemClass tmp_wks
    "txString"      : text
    "txFontHeightF" : get_res_value_keep(opt, "gsnRightStringFontHeightF",0.035)
    "txFontColor"   : get_res_value_keep(opt, "txFontColor","black")
    "txAngleF"      : 0.
    "txFont"        : where(get_res_value_keep(opt,"gsnStringBold",False),22,21)
  end create

  anno = NhlAddAnnotation(plotid,RightString)
  
  setvalues anno
    "amZone"          : 3      ; Just outside plot area
    "amJust"          : "TopRight"
    "amSide"          : "top" 
    "amParallelPosF"  : 0.95+get_res_value_keep(opt, "gsnRightOffsetXF",0.)
    "amOrthogonalPosF": 0.05+get_res_value_keep(opt, "gsnRightOffsetYF",0.)
    "amResizeNotify"  : True     ; Resize if plot resized.
  end setvalues
end

undef("add_CornerString") ; FX| add_CornerString
procedure add_CornerString (plotid,text:string,opt)
  begin
  tmp_wks = NhlGetParentWorkstation(plotid)
  CornerString = create "CornerString" textItemClass tmp_wks
    "txString"      : text
    "txFontHeightF" : get_res_value_keep(opt, "gsnCornerStringFontHeightF",0.035)
    "txFontColor"   : get_res_value_keep(opt, "txFontColor","black")
    "txAngleF"      : 0.
    "txFont"        : 22
  end create

    anno = NhlAddAnnotation(plotid,CornerString)
    
  setvalues anno
    "amZone"          : 3      ; Just outside plot area
    "amJust"          : "topleft"
    "amSide"          : "top" 
    "amParallelPosF"  : -0.1+get_res_value_keep(opt, "gsnCornerOffsetXF",0.)
    "amOrthogonalPosF": 0.05+get_res_value_keep(opt, "gsnCornerOffsetYF",0.)
    "amResizeNotify"  : True     ; Resize if plot resized.
  end setvalues
end

undef("set_XBTick")
procedure set_XBTick(res,dim:string)
begin
  res@tmXBMode = "Explicit"
  spacing = floattointeger(get_res_value_keep(res,"tmXBTickSpacingF",10))
  startF = get_res_value_keep(res,"tmXBTickStartF",0)
  endF = get_res_value_keep(res,"tmXBTickEndF",360)
  res@tmXBValues = ispan(startF,endF,spacing)
  if(is_element(dim,(/"lon","Lon","Longitude","longtude"/)))
    unit = where(res@tmXBValues .lt. 0, -res@tmXBValues+"W",res@tmXBValues+"")
    unit = where(res@tmXBValues .gt. 180, 360-res@tmXBValues+"W",unit)
    unit = where(res@tmXBValues .gt. 0 .and. res@tmXBValues .lt. 180,res@tmXBValues+"E",unit )
  else if(is_element(dim,(/"lat","Lat","latitude","Latitude"/)))
    unit = where(res@tmXBValues .lt. 0, -res@tmXBValues+"S",res@tmXBValues+"")
    unit = where(res@tmXBValues .gt. 0, res@tmXBValues+"N",unit)
  else
    unit = res@tmXBValues
  end if
  end if
  res@tmXBLabels = unit
end
