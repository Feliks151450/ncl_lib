undef("add_vc_dev"); FX| add_vc_dev
procedure add_vc_dev(wks,plotid:graphic,x,y,ranges,opt)
local wks,plot,clr,res
begin
t     = t_value(opt@nyear-2)
  resw                            = True
  resw@gsnDraw = False
  resw@gsnFrame = False
  resw@vcLevelSelectionMode       = "ManualLevels"
  resw@vcGlyphStyle = get_res_value_keep(opt, "vcStyle", "CurlyVector")
  ; resw@vcGlyphStyle               = "CurlyVector";LineArrow" ;
  resw@vcFillArrowHeadXF          = 1.0
  resw@vcRefLengthF               = 0.08
  resw@vcRefMagnitudeF            = get_res_value_keep(opt,"vcRefMagnitudeF",30)
  resw@vcRefAnnoPerimOn = get_res_value_keep(opt,"vcRefAnnoPerimOn",True)
  resw@vcRefAnnoPerimThicknessF = get_res_value_keep(opt,"vcRefAnnoPerimThicknessF",8)
  resw@vcRefAnnoOn = get_res_value_keep(opt,"vcRefAnnoOn",True)
  if(resw@vcRefAnnoPerimThicknessF .eq. 0)
    resw@vcRefAnnoPerimOn = False
  end if
  if(.not. resw@vcRefAnnoPerimOn)
    resw@vcRefAnnoBackgroundColor = -1
  end if
  resw@vcRefAnnoFontHeightF = get_res_value_keep(opt,"vcRefAnnoFontHeightF",0.015)
  resw@vcLevelSpacingF            = 5
  ; printVarSummary(resw)
  resw@vcLineArrowHeadMaxSizeF    = get_res_value_keep(opt,"vcLineArrowHeadMaxSizeF", 0.015)
  resw@vcLineArrowHeadMinSizeF    = get_res_value_keep(opt,"vcLineArrowHeadMinSizeF", 0.08)
  resw@vcMonoFillArrowFillColor   = True
  resw@vcLineArrowThicknessF    = get_res_value_keep(opt,"vcLineArrowThicknessF",8)
  resw@vcMinMagnitudeF            = 0.01
  resw@vcMinDistanceF             = get_res_value_keep(opt,"vcMinDistanceF", 0.032)
  resw@gsnLeftString              = ""
  resw@vcRefAnnoOrthogonalPosF    = get_res_value_keep(opt,"vcRefAnnoOrthogonalPosF",-1.)
  resw@vcRefAnnoParallelPosF    = get_res_value_keep(opt,"vcRefAnnoParallelPosF",1.)
  resw@gsnRightString             = ""
  resw@vcLineArrowColor = get_res_value_keep(opt,"vcLineArrowColor","firebrick1")
  ; resw@vcLineArrowColor = "firebrick1"
  

  if(isatt(opt,"vcRefAnnoString2"))
    resw@vcRefAnnoString2 = opt@vcRefAnnoString2
    resw@vcRefAnnoString2On = True
  else
    resw@vcRefAnnoString2On = False
  end if
  resw@vcVectorDrawOrder = "postdraw"
  if(isatt(opt,"vcRefAnnoString1"))
  ; printx(optw@vcRefAnnoString1)
    resw@vcRefAnnoString1 = opt@vcRefAnnoString1
  end if
  plot = gsn_csm_vector(wks, x, y, resw)
overlay(plotid, plot)
end


undef("plt_cn"); FX| plt_cn
; cmap = read_colormap_file("33colors.rgb")
; gsn_define_colormap(wks,cmap)
function plt_cn(wks,var,ranges,opt)
local wks,plot,clr,res
begin
; 判断var是否为列表类型，若为单变量列表或者普通变量，则只需要画填色
; 目的：同时兼容只画简单图与多变量叠图的需求
if(typeof(var) .eq. "list")
  x = var[0]
  list_size = ListCount(var)
  simple_mode = (list_size .eq. 1)
else
  x = var
  simple_mode = True
end if
; cmap = read_colormap_file("33colors.rgb")
; gsn_define_colormap(wks,cmap)
; opt@polar  = get_res_value_keep(opt,"polar",False)
clr = True
; clr@clr        = (/"#407933","#6CB650","#9BCE7F","#C1E0B8","#FFFFFF","#F6E9BC","#F1CD5C","#F0BF2A","#A57E1E"/)
clr@clr0        = (/"#407933","#6CB650","#9BCE7F","#C1E0B8","#FFFFFF","#F6E9BC","#F1CD5C","#F0B525","#A57E1E"/)
clr@clr1        = (/"#555aa7","#7c7aba","#bab4d8","#ebe9f4","#FFFFFF","#fde9eb","#f8b1b5","#f38380","#f0534e"/)
; x@color = get_res_value_keep(opt,color")



x@cnFillColors = get_res_value_keep(x,"cnFillColors",clr@clr0)
if(dimsizes(x@cnFillColors) .eq. 1)
  x@cnFillColors                := clr@$x@cnFillColors$
end if
if(get_res_value_keep(opt,"xReverseColors",False))
  x@cnFillColors =  x@cnFillColors(::-1)
end if

; if(isatt(y,"cnLineColors"))
;   if(dimsizes(y@cnLineColors) .eq. 1)
;     y@cnLineColors                = clr@$y@cnLineColors$
;   end if
;   if(get_res_value_keep(opt,"yReverseColors",False))
;   y@cnLineColors =  y@cnLineColors(::-1)
;   end if
; end if


cnLevels   = (/-8,-7,-6,-5,-4,-3,-2,-1,1,2,3,4,5,6,7,8/)
; x@cnLevels = get_res_value_keep(x,"cnLevels",(/-4,-3,-2,-1,1,2,3,4/))
setDefaultAtt(x,"cnLevels",[/opt@cnLevels,(/-4,-3,-2,-1,1,2,3,4/)/])
setDefaultAtt(x,"Scale",[/opt@Scale,1/])
; y@cnLevels = get_res_value_keep(y,"cnLevels",cnLevels)
; z@cnLevels = get_res_value_keep(z,"cnLevels",cnLevels)
; x@Scale    = get_res_value_keep(x,"Scale",1)
; y@Scale    = get_res_value_keep(y,"Scale",1)
; z@Scale    = get_res_value_keep(z,"Scale",1)

res                      = True
; res@mpOceanFillColor = 1
  res@tmXTOn               = False
  res@tmYROn               = False
  res@vpWidthF             = get_res_value_keep(opt,"vpWidthF",0.82)
  vpHeightF = res@vpWidthF*(ranges(1)-ranges(0))*1.5/(ranges(3)-ranges(2))
  res@vpHeightF            = get_res_value_keep(opt,"vpHeightF",vpHeightF)
  res@vpXF = get_res_value_keep(opt,"vpXF",0.12)
  res@vpYF = get_res_value_keep(opt,"vpYF",0.9)
; if(dimsizes(dimsizes(y)) .ne. 1) opt@gsnDraw = False end if
  res@tmXBOn = get_res_value_keep(opt,"tmXBOn",True)
  res@gsnDraw              = get_res_value_keep(opt,"gsnDraw",True)
  res@gsnFrame             = get_res_value_keep(opt,"gsnDraw",True)
  res@gsnAddCyclic         = get_res_value_keep(opt,"gsnAddCyclic",False)
  res@cnFillOn             = True
  res@cnLevelSelectionMode = "ExplicitLevels"
  res@tmXMajorGridLineColor = 3
  res@tmXBMajorLengthF = get_res_value_keep(opt,"tmXBMajorLengthF",0.01)
  res@tmXBLabelDeltaF = -0.4
  res@tmYLLabelDeltaF = -0.4


  if(isatt(opt,"tiXAxisString"))
    res@tiXAxisOn = True
    res = get_res_eq(opt,"tiXAxis")
    res@tiXAxisFontHeightF = get_res_value_keep(opt,"tiXAxisFontHeightF",0.03)
  end if

  if(isatt(opt,"tiYAxisString"))
    res@tiYAxisOn = True
    res = get_res_eq(opt,"tiYAxis")
    res@tiYAxisFontHeightF = get_res_value_keep(opt,"tiYAxisFontHeightF",0.03)
  end if
  res@tmBorderThicknessF = get_res_value_keep(opt,"tmBorderThicknessF",5)
  res@lbLabelBarOn = get_res_value_keep(opt,"lbLabelBarOn",True)
  if(res@lbLabelBarOn)
    res = get_res_eq(opt,"lb")
    res = True
    res@lbLabelAutoStride = False
    setLabelbar(res)
    if(isatt(opt,"lbTitleString"))
      setLabelbarTitle(res,opt@lbTitleString)
    end if
    ; if(isatt(opt,"lbLabelStride"))
    ;   res@lbLabelStride = opt@lbLabelStride
    ; end if
    if(is_element(res@lbOrientation,(/"Horizontal","horizontal"/)))
      res@pmLabelBarOrthogonalPosF = get_res_value_keep(opt,"pmLabelBarOrthogonalPosF",0.15)
      res@pmLabelBarParallelPosF   = get_res_value_keep(opt,"pmLabelBarParallelPosF",0.5)
      res@pmLabelBarWidthF         = get_res_value_keep(opt,"pmLabelBarWidthF",res@vpWidthF)
      res@pmLabelBarHeightF        = get_res_value_keep(opt,"pmLabelBarHeightF",0.15)
    else
      res@pmLabelBarWidthF         = get_res_value_keep(opt,"pmLabelBarWidthF",0.15)
      res@pmLabelBarHeightF        = get_res_value_keep(opt,"pmLabelBarHeightF",res@vpHeightF+0.15)
      res@pmLabelBarOrthogonalPosF = get_res_value_keep(opt,"pmLabelBarOrthogonalPosF",0.05)
      res@pmLabelBarParallelPosF   = get_res_value_keep(opt,"pmLabelBarParallelPosF",0.45)
    end if
  end if


  reso = res
  res2 = res
  res@mpMinLatF           = ranges(0)
  res@mpMaxLatF           = ranges(1)
  res@mpCenterLonF        = ranges(2)/2+ranges(3)/2
  res@mpFillOn = True
  res@tmXBMinorOn         = False
  res@tmXBLabelStride     = get_res_value_keep(opt,"tmXBLabelStride",2)
  res@tmYLLabelStride     = get_res_value_keep(opt,"tmYLLabelStride",2)
  res@tmYLMinorOn         = False



; if(dimsizes(dimsizes(x)) .ne. 1)
; print(res@pmLabelBarHeightF )
  res@mpFillOn            = True
  res@cnLinesOn = get_res_value_keep(x,"cnLinesOn",False)
  ; res@cnLinesOn           = False  ;where(isatt(opt, "cnLinesOn"), opt@cnLinesOn, False)
  res@cnLineLabelsOn      = False

  opt@tmBorderThicknessF = res@tmBorderThicknessF
  res@tmXBMajorThicknessF = res@tmBorderThicknessF
  res@tmYLMajorThicknessF = res@tmBorderThicknessF
  ; res@cnLineThicknessF   = get_res_value_keep(y,"cnLineThicknessF",res@tmBorderThicknessF)

  
  res@gsnContourNegLineDashPattern = get_res_value_keep(opt,"gsnContourNegLineDashPattern",1)
  ; print(reso@cnLineThicknessF)


  res@cnLevels            = x@cnLevels*x@Scale
  res@tmYLOn = get_res_value_keep(opt,"tmYLOn",True )


  if(typeof(res@cnLevels) .eq. "float")
    format = get_res_value_keep(opt,"lbLabelFormat","%0.2f")
    res@lbLabelStrings = sprintf(format, res@cnLevels)
  end if
  ; if(get_res_value_keep(opt,"usingColorMap",False))
  ;   res@cnFillPalette = cmap
  ; else
    res@cnFillColors = x@cnFillColors
  ; end if

  res@tmYLLabelFontHeightF        = get_res_value_keep(opt,"tmLabelFontHeightF",0.03)
  res@tmXBLabelFontHeightF        = get_res_value_keep(opt,"tmLabelFontHeightF",0.03)
  res@mpGeophysicalLineThicknessF = 0.5
  res@mpGeophysicalLineColor      = "dark slate gray"
  res@mpOutlineOn                 = True
  res@mpOutlineBoundarySets       = "Geophysical"
  res@mpNationalLineThicknessF    = 3
  res@mpNationalLineColor         = "dark slate gray"
  res@tmYLLabelsOn                = get_res_value_keep(opt,"tmYLLabelsOn",True)
  res@tmXBLabelsOn                = get_res_value_keep(opt,"tmXBLabelsOn",True)
  ;干掉愚蠢的gsnString，后面自己写
  res@gsnLeftString = ""
  res@gsnRightString = ""
if(isatt(opt,"polar") .and. opt@polar)
  res@vpHeightF    = 0.8 
  res@gsnPolar     = get_res_value_keep(opt,"gsnPolar","NH")
  plot = gsn_csm_contour_map_polar(wks, x, res)
else
  res@mpShapeMode        = "FreeAspect"
  res@gsnMajorLonSpacing = get_res_value_keep(opt,"gsnMajorLonSpacing",10)
  res@gsnMajorLatSpacing = get_res_value_keep(opt,"gsnMajorLatSpacing",10)
  res@mpMinLonF          = ranges(2)
  res@mpMaxLonF          = ranges(3)
  ; res@tmXBLabelDeltaF    = get_res_value_keep(opt,"tmXBLabelDeltaF",0.1)
  res@tmYLTickSpacingF   = get_res_value_keep(opt,"tmYLTickSpacingF",10)
  res@tmXBTickSpacingF   = get_res_value_keep(opt,"tmXBTickSpacingF",10)
  if(get_res_value_keep(opt,"gsnMaskLambertConformal",False))
    res@mpProjection            = "LambertConformal"
    ; res@mpProjection = "LambertEqualArea"
    res@gsnMaskLambertConformal = True
    res@mpLambertMeridianF      = res@mpCenterLonF
    res@mpLambertParallel1F = get_res_value_keep(opt,"mpLambertParallel1F",20)
    res@mpLambertParallel2F = get_res_value_keep(opt,"mpLambertParallel2F",30)
    if(get_res_value_keep(opt,"debug",False))
      res@name = "plot_res"
      isOverWrite = get_res_value_keep(opt,"overWrite",True)
      md_print(res,isOverWrite)
    end if
    plot = gsn_csm_contour_map(wks, x, res)
  else 
    if(get_res_value_keep(opt,"debug",False))
      res@name = "plot_res"
      isOverWrite = get_res_value_keep(opt,"overWrite",True)
      md_print(res,isOverWrite)
    end if
    plot = gsn_csm_contour_map_ce(wks, x, res)
  end if
end if
; end if
  ;手动接管gsnLeftString和gsnRightString
  if(isatt(opt,"gsnLeftString"))
    res_text = get_res_eq(opt,"gsnLeft")
    add_LeftString(plot,opt@gsnLeftString,res_text)
  end if

  if(isatt(opt,"gsnRightString"))
    res_text = get_res_eq(opt,"gsnRight")
    add_RightString(plot,opt@gsnRightString,res_text)
  end if

  if(isatt(opt,"gsnCornerString"))
    res_text = get_res_eq(opt,"gsnCorner")
    add_CornerString(plot,opt@gsnCornerString,res_text)
  end if



if(.not. simple_mode)
do i = 1,list_size-1,1
  y := var[i]
  setDefaultAtt(y,"mode","contour")
  ; y@mode = get_res_value_keep(y,"mode","contour");contour or stippling

  ; copy_VarAtts(y,reso)
  ; reso = get_res_eq(y,"cn")
  reso := True
  reso@cnLevelSelectionMode = "ExplicitLevels"
  reso@gsnDraw = False
  reso@gsnFrame = False
  reso@cnLevels = y@cnLevels*get_res_value_keep(y,"Scale",1)
  reso@cnLineLabelsOn = False
  reso@gsnLeftString = ""
  reso@gsnRightString = ""
  if(y@mode .eq. "contour")
    reso@cnLinesOn = True
    reso@cnMonoLineColor = True
    reso@cnInfoLabelOn = False
    reso@cnLineColor = y@cnLineColor
    if(isatt(y,"drawOrder"))
      reso@cnLineDrawOrder = y@drawOrder
    end if
    reso@cnLineThicknessF = get_res_value_keep(y,"cnLineThicknessF", 5)
    if(isatt(y,"cnLineColors"))
      reso@cnMonoLineColor = False
      reso@cnLineColors = y@cnLineColors
    end if
    if(isatt(y,"cnLineThicknesses"))
      reso@cnLineThicknesses = y@cnLineThicknesses
      reso@cnMonoLineThickness = False
    end if
  else if(y@mode .eq. "stippling")
    stipplingColor = get_res_value_keep(y,"stipplingColor","white")
    reso@cnFillOn = True
    reso@cnLinesOn = False
    reso@lbLabelBarOn = False
    reso@cnInfoLabelOn = False
    reso@cnMonoFillPattern = False
    reso@cnFillPatterns = get_res_value_keep(y,"cnFillPatterns",(/17,17,-1,17,17/))
    reso@cnFillColors   = get_res_value_keep(y,"cnFillColors",(/stipplingColor,stipplingColor,"gray",stipplingColor,stipplingColor/))
    reso@cnLinesOn      = False
    if(isatt(y,"drawOrder"))
      reso@cnFillDrawOrder = y@drawOrder
    end if
    reso@cnFillScaleF = get_res_value_keep(y,"cnFillScaleF",2.0)
    reso@cnFillDotSizeF = get_res_value_keep(y,"cnFillDotSizeF",0.001)
  end if
  end if
  plot_o = gsn_csm_contour(wks, y, reso)
  overlay(plot, plot_o)
end do
end if

if(get_res_value_keep(opt,"dots",False))
  resl = True
  resl@gsLineColor      = get_res_value_keep(opt,"dotsColor","firebrick1")
  resl@gsLineThicknessF = get_res_value_keep(opt,"dotsLineThicknessF",15.0)
  ; resl@tfPolyDrawOrder = "PostDraw"
  ; resl@xyCurveDrawOrder = "PostDraw"
  str = unique_string("polyline")
  plot@$str$            = gsn_add_polyline(wks, plot,opt@dotslon,opt@dotslat,resl)
  if(get_res_value_keep(opt,"dots1",False))
    str1 = unique_string("polyline") 
    plot@$str1$ = gsn_add_polyline(wks, plot,opt@dotslon1,opt@dotslat1,resl)
  end if
  if(get_res_value_keep(opt,"dots2",False))
    str2 = unique_string("polyline") 
    plot@$str2$ = gsn_add_polyline(wks, plot,opt@dotslon2,opt@dotslat2,resl)
  end if
end if
return(plot)
end

undef("plt_cn_ver"); FX| plt_cn_ver
; cmap = read_colormap_file("33colors.rgb")
; gsn_define_colormap(wks,cmap)
function plt_cn_ver(wks,var,ranges,opt)
begin
; 判断var是否为列表类型，若为单变量列表或者普通变量，则只需要画填色
; 目的：同时兼容只画简单图与多变量叠图的需求
if(typeof(var) .eq. "list")
  x = var[0]
  list_size = ListCount(var)
  simple_mode = (list_size .eq. 1)
else
  x = var
  simple_mode = True
end if
; cmap = read_colormap_file("33colors.rgb")
; gsn_define_colormap(wks,cmap)
; opt@polar  = get_res_value_keep(opt,"polar",False)
clr = True
; clr@clr        = (/"#407933","#6CB650","#9BCE7F","#C1E0B8","#FFFFFF","#F6E9BC","#F1CD5C","#F0BF2A","#A57E1E"/)
clr@clr0        = (/"#407933","#6CB650","#9BCE7F","#C1E0B8","#FFFFFF","#F6E9BC","#F1CD5C","#F0B525","#A57E1E"/)
clr@clr1        = (/"#555aa7","#7c7aba","#bab4d8","#ebe9f4","#FFFFFF","#fde9eb","#f8b1b5","#f38380","#f0534e"/)
; x@color = get_res_value_keep(opt,color")



x@cnFillColors = get_res_value_keep(x,"cnFillColors",clr@clr0)
if(dimsizes(x@cnFillColors) .eq. 1)
  x@cnFillColors                := clr@$x@cnFillColors$
end if
if(get_res_value_keep(opt,"xReverseColors",False))
  x@cnFillColors =  x@cnFillColors(::-1)
end if

; if(isatt(y,"cnLineColors"))
;   if(dimsizes(y@cnLineColors) .eq. 1)
;     y@cnLineColors                = clr@$y@cnLineColors$
;   end if
;   if(get_res_value_keep(opt,"yReverseColors",False))
;   y@cnLineColors =  y@cnLineColors(::-1)
;   end if
; end if


cnLevels   = (/-8,-7,-6,-5,-4,-3,-2,-1,1,2,3,4,5,6,7,8/)
; x@cnLevels = get_res_value_keep(x,"cnLevels",(/-4,-3,-2,-1,1,2,3,4/))
setDefaultAtt(x,"cnLevels",(/-4,-3,-2,-1,1,2,3,4/))
setDefaultAtt(x,"Scale",[/opt@Scale,1/])
; y@cnLevels = get_res_value_keep(y,"cnLevels",cnLevels)
; z@cnLevels = get_res_value_keep(z,"cnLevels",cnLevels)
; x@Scale    = get_res_value_keep(x,"Scale",1)
; y@Scale    = get_res_value_keep(y,"Scale",1)
; z@Scale    = get_res_value_keep(z,"Scale",1)

res                      = True
; res@mpOceanFillColor = 1
  res@tmXTOn               = False
  res@tmYROn               = False
  res@vpHeightF            = get_res_value_keep(opt,"vpHeightF",0.6)
  res@vpWidthF             = get_res_value_keep(opt,"vpWidthF",0.82)
  res@vpXF = get_res_value_keep(opt,"vpXF",0.12)
  res@vpYF = get_res_value_keep(opt,"vpYF",0.9)
; if(dimsizes(dimsizes(y)) .ne. 1) opt@gsnDraw = False end if
  res@tmXBOn = get_res_value_keep(opt,"tmXBOn",True)
  res@gsnDraw              = get_res_value_keep(opt,"gsnDraw",True)
  res@gsnFrame             = get_res_value_keep(opt,"gsnDraw",True)
  res@gsnAddCyclic         = get_res_value_keep(opt,"gsnAddCyclic",False)
  res@cnFillOn             = True
  res@gsnPresHgtHeightLabelOn = False
  res@cnLevelSelectionMode = "ExplicitLevels"
  res@tmXMajorGridLineColor = 3
  res@tmXBMajorLengthF = get_res_value_keep(opt,"tmXBMajorLengthF",0.01)
  res@tmXBLabelDeltaF = -0.4
  res@tmYLLabelDeltaF = -0.4
  res@cnFillDrawOrder = "predraw"
  res@trXMaxF = ranges(3)
  res@trXMinF = ranges(2)
  res@trYMaxF = max(ranges(:1))
  res@trYMinF = min(ranges(:1))

  res@tiYAxisString = ""
  if(isatt(opt,"tiXAxisString"))
    res@tiXAxisOn = True
    res = get_res_eq(opt,"tiXAxis")
    res@tiXAxisFontHeightF = get_res_value_keep(opt,"tiXAxisFontHeightF",0.03)
  end if

  if(isatt(opt,"tiYAxisString"))
    res@tiYAxisOn = True
    res = get_res_eq(opt,"tiYAxis")
    res@tiYAxisFontHeightF = get_res_value_keep(opt,"tiYAxisFontHeightF",0.03)
  end if
  res@tmBorderThicknessF = get_res_value_keep(opt,"tmBorderThicknessF",5)
  res@lbLabelBarOn = get_res_value_keep(opt,"lbLabelBarOn",True)
  if(res@lbLabelBarOn)
    res = get_res_eq(opt,"lb")
    res = True
    res@lbLabelAutoStride = False
    setLabelbar(res)
    if(isatt(opt,"lbTitleString"))
      setLabelbarTitle(res,opt@lbTitleString)
    end if
    ; if(isatt(opt,"lbLabelStride"))
    ;   res@lbLabelStride = opt@lbLabelStride
    ; end if
    if(is_element(res@lbOrientation,(/"Horizontal","horizontal"/)))
      res@pmLabelBarOrthogonalPosF = get_res_value_keep(opt,"pmLabelBarOrthogonalPosF",0.15)
      res@pmLabelBarParallelPosF   = get_res_value_keep(opt,"pmLabelBarParallelPosF",0.5)
      res@pmLabelBarWidthF         = get_res_value_keep(opt,"pmLabelBarWidthF",res@vpWidthF)
      res@pmLabelBarHeightF        = get_res_value_keep(opt,"pmLabelBarHeightF",0.15)
    else
      res@pmLabelBarWidthF         = get_res_value_keep(opt,"pmLabelBarWidthF",0.15)
      res@pmLabelBarHeightF        = get_res_value_keep(opt,"pmLabelBarHeightF",res@vpHeightF+0.15)
      res@pmLabelBarOrthogonalPosF = get_res_value_keep(opt,"pmLabelBarOrthogonalPosF",0.05)
      res@pmLabelBarParallelPosF   = get_res_value_keep(opt,"pmLabelBarParallelPosF",0.45)
    end if
  end if
  res@tmXBMinorOn         = False
  res@tmXBLabelStride     = get_res_value_keep(opt,"tmXBLabelStride",2)
  res@tmYLLabelStride     = get_res_value_keep(opt,"tmYLLabelStride",2)
  res@tmYLMinorOn         = False
  ; res@cnFillDrawOrder = "predraw"



; if(dimsizes(dimsizes(x)) .ne. 1)
; print(res@pmLabelBarHeightF )
  res@cnLinesOn = get_res_value_keep(x,"cnLinesOn",False)
  ; res@cnLinesOn           = False  ;where(isatt(opt, "cnLinesOn"), opt@cnLinesOn, False)
  res@cnLineLabelsOn      = False

  opt@tmBorderThicknessF = res@tmBorderThicknessF
  res@tmXBMajorThicknessF = res@tmBorderThicknessF
  res@tmYLMajorThicknessF = res@tmBorderThicknessF
  ; res@cnLineThicknessF   = get_res_value_keep(y,"cnLineThicknessF",res@tmBorderThicknessF)

  
  res@gsnContourNegLineDashPattern = get_res_value_keep(opt,"gsnContourNegLineDashPattern",1)
  ; print(reso@cnLineThicknessF)


  res@cnLevels            = x@cnLevels*x@Scale
  res@tmYLOn = get_res_value_keep(opt,"tmYLOn",True )


  if(typeof(res@cnLevels) .eq. "float")
    format = get_res_value_keep(opt,"lbLabelFormat","%0.2f")
    res@lbLabelStrings = sprintf(format, res@cnLevels)
  end if
  ; if(get_res_value_keep(opt,"usingColorMap",False))
  ;   res@cnFillPalette = cmap
  ; else
    res@cnFillColors = x@cnFillColors
  ; end if

  res@tmYLLabelFontHeightF        = get_res_value_keep(opt,"tmLabelFontHeightF",0.03)
  res@tmXBLabelFontHeightF        = get_res_value_keep(opt,"tmLabelFontHeightF",0.03)
  res@tmYLLabelsOn                = get_res_value_keep(opt,"tmYLLabelsOn",True)
  res@tmXBLabelsOn                = get_res_value_keep(opt,"tmXBLabelsOn",True)
  ;干掉愚蠢的gsnString，后面自己写
  res@gsnLeftString = ""
  res@gsnRightString = ""
  res@tmYLTickSpacingF   = get_res_value_keep(opt,"tmYLTickSpacingF",10)
  res@tmXBTickSpacingF   := get_res_value_keep(opt,"tmXBTickSpacingF",10)
  vardim = getvardims(x)
  if(is_element("lat",vardim))
    set_XBTick(res,"lat")
  else if (is_element("lon",vardim)) then 
    set_XBTick(res,"lon")
  end if
  end if

    if(get_res_value_keep(opt,"debug",False))
      res@name = "plot_res"
      isOverWrite = get_res_value_keep(opt,"overWrite",True)
      md_print(res,isOverWrite)
    end if
  plot = gsn_csm_pres_hgt(wks, x, res)

  ; 手动接管gsnLeftString和gsnRightString
  if(isatt(opt,"gsnLeftString"))
    res_text = get_res_eq(opt,"gsnLeft")
    add_LeftString(plot,opt@gsnLeftString,res_text)
  end if

  if(isatt(opt,"gsnRightString"))
    res_text = get_res_eq(opt,"gsnRight")
    add_RightString(plot,opt@gsnRightString,res_text)
  end if

  if(isatt(opt,"gsnCornerString"))
    res_text = get_res_eq(opt,"gsnCorner")
    add_CornerString(plot,opt@gsnCornerString,res_text)
  end if



if(.not. simple_mode)
do i = 1,list_size-1,1
  y := var[i]
  setDefaultAtt(y,"mode","contour")
  ; y@mode = get_res_value_keep(y,"mode","contour");contour or stippling

  ; copy_VarAtts(y,reso)
  ; reso = get_res_eq(y,"cn")
  reso := True
  reso@cnLevelSelectionMode = "ExplicitLevels"
  reso@gsnDraw = False
  reso@gsnFrame = False
  reso@cnLevels = y@cnLevels*get_res_value_keep(y,"Scale",1)
  reso@cnLineLabelsOn = False
  reso@gsnLeftString = ""
  reso@gsnRightString = ""
  if(y@mode .eq. "contour")
    reso@cnLinesOn = True
    reso@cnMonoLineColor = True
    reso@cnInfoLabelOn = False
    reso@cnLineColor = get_res_value_keep(y,"cnLineColor","black") 
    if(isatt(y,"drawOrder"))
      reso@cnLineDrawOrder = y@drawOrder
    end if
    reso@cnLineThicknessF = get_res_value_keep(y,"cnLineThicknessF", 5)
    if(isatt(y,"cnLineColors"))
      reso@cnMonoLineColor = False
      reso@cnLineColors = y@cnLineColors
    end if
    if(isatt(y,"cnLineThicknesses"))
      reso@cnLineThicknesses = y@cnLineThicknesses
      reso@cnMonoLineThickness = False
    end if
  else if(y@mode .eq. "stippling")
    stipplingColor = get_res_value_keep(y,"stipplingColor","white")
    reso@cnFillOn = True
    reso@cnLinesOn = False
    reso@lbLabelBarOn = False
    reso@cnInfoLabelOn = False
    reso@cnMonoFillPattern = False
    reso@cnFillPatterns = get_res_value_keep(y,"cnFillPatterns",(/17,17,-1,17,17/))
    reso@cnFillColors   = get_res_value_keep(y,"cnFillColors",(/stipplingColor,stipplingColor,"gray",stipplingColor,stipplingColor/))
    reso@cnLinesOn      = False
    if(isatt(y,"drawOrder"))
      reso@cnFillDrawOrder = y@drawOrder
    end if
    reso@cnFillScaleF = get_res_value_keep(y,"cnFillScaleF",2.0)
    reso@cnFillDotSizeF = get_res_value_keep(y,"cnFillDotSizeF",0.001)
  end if
  end if
  plot_o = gsn_csm_contour(wks, y, reso)
  overlay(plot, plot_o)
end do
end if

if(get_res_value_keep(opt,"dots",False))
  resl = True
  resl@gsLineColor      = get_res_value_keep(opt,"dotsColor","firebrick1")
  resl@gsLineThicknessF = get_res_value_keep(opt,"dotsLineThicknessF",15.0)
  ; resl@tfPolyDrawOrder = "PostDraw"
  ; resl@xyCurveDrawOrder = "PostDraw"
  str = unique_string("polyline")
  plot@$str$            = gsn_add_polyline(wks, plot,opt@dotslon,opt@dotslat,resl)
  if(get_res_value_keep(opt,"dots1",False))
    str1 = unique_string("polyline") 
    plot@$str1$ = gsn_add_polyline(wks, plot,opt@dotslon1,opt@dotslat1,resl)
  end if
  if(get_res_value_keep(opt,"dots2",False))
    str2 = unique_string("polyline") 
    plot@$str2$ = gsn_add_polyline(wks, plot,opt@dotslon2,opt@dotslat2,resl)
  end if
end if
return(plot)
end

undef("add_topo_ver") ; FX| add_topo_ver
function add_topo_ver(plotid:graphic,range,pres,opt)
;必须得是function，因为必须要把plot传回去，不然填色叠不上
  begin
  tmp_wks = NhlGetParentWorkstation(plotid)
  ; pres       = (/1000,975,950,925,900,875,850,825,800,775,750,700,650,600,550,500,450,400,350,300,250,225,200,175,150,125,100/)
  ; pres       = pres(::-1)
  pres@units = "hecto-pascals"
  f          = addfile(readpath(0)+"ETOPO1.nc","r")
  topo       = f->z({range(0):range(1)},{range(2):range(3)})
  if(opt@Orientation .eq. "meridional")
    topo := dim_avg_n_Wrap(topo,1)
  else
    topo := dim_avg_n_Wrap(topo,0)
  end if
  topo = (/1013.25*(1-topo*0.0065/288.15)^5.25145/)
  topo = where(topo .gt. 1000, 1000, topo)
  res_t = True
  res_t@tmYRMode = "Automatic"
  set_pres_hgt_axes(pres,res_t,False)
  res_t@trYReverse            = True
  res_t@trYMaxF               = 1000
  res_t@trYMinF               = 100
  res_t@trYLog                = True
  res_t@gsnYRefLine           = 1000
  res_t@gsnFrame              = False
  res_t@gsnDraw               = False
  res_t@gsnAboveYRefLineColor = "black"
  res_t@gsnBelowYRefLineColor = "black"
  res_t@xyCurveDrawOrder      = "postdraw"
  res_t@tfPolyDrawOrder = "postdraw"
  res_t@tiYAxisString         = ""
  str = unique_string("topo")
  if(opt@Orientation .eq. "meridional")
    plot = gsn_csm_xy(tmp_wks,topo&lat,topo,res_t)
  else
    plot = gsn_csm_xy(tmp_wks,topo&lon,topo,res_t)
  end if
  overlay(plotid,plot)
  return(plot)
end