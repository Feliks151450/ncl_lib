undef("reg_dev") ; FX| reg_dev
function reg_dev(wks,ts,type,ranges,opt)
  begin
  clr = (/"#407933","#72BF4F","#9BCE7F","#C1E0B8","#FFFFFF","#F6E9BC","#F1CD5C","#F0BF2A","#A57E1E"/)
  res = opt
  res = True
  localpath = readpath(1)
  opt@polar = get_res_value_keep(opt,"polar",False)
  ; opt@with  = get_res_value_keep(opt,"with",(/ts0@type,ts1@type/))
  nyear     = dimsizes(ts&year)
  
  opt@preyear = get_res_value_keep(opt,"preyear",False)
  t = t_value(nyear-2)
  ;plot 
  opt@data=1
  ; type@source = "jra55"
  type@year := ts&year
  opt@lonP0=False 
  opt@vertical=False
  if((ranges(3)-ranges(2)) .eq. 360)
    range = (/ranges(0)-2,ranges(1)+2,ranges(2),ranges(3)/)
  else
    range = (/ranges(0)-2,ranges(1)+2,ranges(2)-2,ranges(3)+2/)
  end if
  ; range = (/ranges(0)-2,ranges(1)+2,ranges(2)-2,ranges(3)+2/)
  ; range = ranges
  if(opt@polar) range(1:3) = (/90,0,360/) end if
  X := predata(type,range,opt)
  if(isatt(opt,"multi"))
    X  = (/X*opt@multi/)
  end if


  if(type .eq. 14) X = (/X*1e+6/) end if
  if(type .eq. 1) X = (/X*0.01/) end if
  cor := escorc_n(ts, X, 0, 0)
  rec := regCoef_n(ts, X, 0, 0)
  ; printVarSummary(rec)
  ; rec0 = dim_avg_n(rec,0)
  ; print(dim_avg_n(rec0,0))
  ; print(typeof(wks))
  if(.not. isgraphic(wks))
    copy_VarCoords(X(0,:,:), rec)
    return(rec)
  end if


  if(isatt(res,"cnLineThicknessF")) rec@cnLineThicknessF = res@cnLineThicknessF end if
  ; cor := smth9_Wrap(cor, 0.5, 0., False)
  
  ; cor@cnLevels         = (/-t@r999,-t@r99,-t@r95,-t@r90,t@r90,t@r95,t@r99,t@r999/)
    ; cor@cnLevels         = (/-0.9,-0.7,-0.5,-0.3,0.3,0.5,0.7,0.9/)
  ; cor@cnLevels         := (/-t@r99,-t@r95,-t@r90,t@r90,t@r95,t@r99/)

  ; rec@cnFillColors = (/clr(0),clr(1),clr(3),clr(4),clr(5),clr(7),clr(8)/)
  cor@reverseColors    := get_res_value_keep(opt,"reverseColors",False)
  rec@Scale            := opt@Scale

  ; rec@cnFillColors = opt@cnFillColors
  ; if(isatt(opt,"cnLineThicknessF"))
  ; rec@cnLineThicknessF := opt@cnLineThicknessF
  ; end if
  rec@gsnContourNegLineDashPattern = get_res_value_keep(opt,"gsnContourNegLineDashPattern",1)
  copy_VarCoords( X(0,:,:), cor)
  copy_VarCoords( X(0,:,:), rec)
  if(get_res_value_keep(opt,"returnRec",False))
    return(rec)
  end if
;画图属性继承区，可折叠
  res@gsnDraw = False
  res@gsnFrame = False
  ; if(X@mon_name .eq. "JA")
    ; res@gsnRightString = get_res_value_keep(res,"addRightString","")+X@mon_name
  ; else
    res@gsnRightString = get_res_value_keep(res,"addRightString","")+get_res_value_keep(opt,"gsnRightString",X@mon_name) 

  ; end if
    res@lbLabelBarOn                 = get_res_value_keep(opt,"lbLabelBarOn",True)
  ; res@gsnRightString               = get_res_value_keep(opt,"addRightString","") ;+ X@mon_name+where(opt@preyear,"(-1)","")
    res@lbOrientation                = get_res_value_keep(opt,"lbOrientation","Horizontal")
  ; opt@polar                        = type .eq. 8
    res@tmXBLabelStride              = get_res_value_keep(opt,"tmXBLabelStride",2)
    res@tmYLLabelStride              = get_res_value_keep(opt,"tmYLLabelStride",2)
    ; rec@gsnContourNegLineDashPattern = get_res_value_keep(opt,"gsnContourNegLineDashPattern",12)
    res@gsnStringFontHeightF         = get_res_value_keep(opt,"gsnStringFontHeightF",0.027)
  ; if(res@lbOrientation .eq. "Vertical")
  ;   ; res@pmLabelBarHeightF = opt@vpHeightF*1.08
  ;   res@pmLabelBarHeightF = get_res_value_keep(opt,"pmLabelBarHeightF",opt@vpHeightF*1.08)
  ;   ; res@pmLabelBarWidthF = get_res_value_keep(opt,)
  ;   res@lbLabelFontHeightF = get_res_value_keep(opt,"lbLabelFontHeightF",0.03)
  ; ; else
  ; ;   res@pmLabelBarHeightF = get_res_value_keep(opt,"")
  ; ;   res@pmLabelBarWidthF = 1.0
  ; end if
  ; if(isatt(opt, "dots")) res = get_res_eq(opt,"dots") end if
  ; if(get_res_value_keep(opt,"dots",False)) 
    ; res@dots = True
    ; res@dotslon = opt@dotslon
    ; res@dotslat = opt@dotslat
    ; res@dotscolor = get_res_value_keep(opt,"dotscolor","tomato")
    ; res@dots1 = get_res_value_keep(opt,"dots1",False)
    ; res@dotslon1 = get_res_value_keep(opt,"dotslon1",False)
    ; res@dotslat1 = get_res_value_keep(opt,"dotslat1",False)
    ; res@dots2 = get_res_value_keep(opt,"dots2",False)
    ; res@dotslon2 = get_res_value_keep(opt,"dotslon2",False)
    ; res@dotslat2 = get_res_value_keep(opt,"dotslat2",False)
  ; end if
  if(opt@polar)then
    res@polar = True
    res@gsnAddCyclic = True
    res@vpHeightF = 0.8
    res@gsnPolar = "NH"
    else
    res@polar = False
    res@vpHeightF = get_res_value_keep(opt,"vpHeightF",0.4)
    res@vpWidthF = get_res_value_keep(opt,"vpWidthF",0.8)
    res@vpXF = 0.0
    res@gsnMaskLambertConformal = get_res_value_keep(opt,"gsnMaskLambertConformal",False)
    res@gsnMajorLonSpacing = get_res_value_keep(opt,"gsnMajorLonSpacing",10)
  end if
  ; gsnLeftString = get_res_value_keep(opt,"gsnLeftString",ts@name);+" cor. "+X@name) 
  gsnLeftString = get_res_value_keep(opt,"gsnLeftString",X@name+" linked to "+ts@name)
  ; if(ts@name .eq. "EAJII")
    ; res@gsnLeftString = get_res_value_keep(opt,"addLeftString","") + X@name
  ; else
    res@gsnLeftString = gsnLeftString
  ; end if
  ; res@gsnLeftString=item(a)+" "+ts@name+gsnLeftString
  ; res@xcnLevels = cor@cnLevels
  ; res@ycnLevels = rec@cnLevels

  cor@cnLinesOn = False
  res@plot_mode = get_res_value_keep(opt,"plot_mode",0)
  if(res@plot_mode .eq. 0)
    x = cor
    x@cnLevels := get_res_value_keep(opt,"cnLevels",(/-t@r999,-t@r99,-t@r95,-t@r90,t@r90,t@r95,t@r99,t@r999/))
    y = rec
  else
    x = rec
    if(isatt(opt,"cnLevels"))
      x@cnLevels := opt@cnLevels
    end if
    y = cor
    y@cnLevels := (/-t@r90,t@r90/)
    y@gsnContourNegLineDashPattern = 0
    if(isatt(opt,"cnLineThicknessF"))
      y@cnLineThicknessF = opt@cnLineThicknessF
    end if
  end if
  if(.not. get_res_value_keep(opt,"cnLinesOn",True))
    y := 0
  end if
  
  if(get_res_value_keep(opt,"smoothing",False));平滑
      y := smth9_Wrap(y, 0.5, 0.5, False)
  end if
  if(isatt(opt,"cnFillColors")) x@cnFillColors := opt@cnFillColors end if
  if(isatt(opt,"mode") .and. opt@mode .eq. "stippling")
    print("stippling")
    y@cnLevels := (/-900,-t@r95,t@r95,900/)
    if(isatt(opt,"cnFillScaleF"))
      y@cnFillScaleF = opt@cnFillScaleF
    end if
    if(isatt(opt,"cnFillDotSizeF"))
      y@cnFillDotSizeF = opt@cnFillDotSizeF
    end if
    if(isatt(opt,"stipplingColor"))
      y@stipplingColor = opt@stipplingColor
    end if
    var = [/x,y/]
    plot = plt_cn(wks,var,ranges,res)
  else
    var = [/x,y/]
    plot = plt_cn(wks,var,ranges,res)
  end if

  if(get_res_value_keep(opt,"vector",False))
      type_u        = type
      if(isatt(opt,"surf_wind") .and. opt@surf_wind)
        type_u = 10
        type_v = 11
      else
        type_u = 3
        type_u@level  = get_res_value_keep(opt,"vclevel",850)
        type_v = 4
      end if
      type_u@source = "jra55"
      copy_VarAtts(type_u,type_v)
      u             = predata(type_u,ranges,opt)
      v             = predata(type_v,ranges,opt)
      rec_u         = regCoef_n(ts, u, 0, 0)
      rec_v         = regCoef_n(ts, v, 0, 0)
      t_v           = onedtond(rec_v@tval, dimsizes(rec_v))
      t_u           = onedtond(rec_u@tval, dimsizes(rec_u))
      rec_u         = where(t_u .le. t@t90 .and. t_u .ge. -t@t90 .and. t_v .le. t@t90 .and. t_v .ge. -t@t90, rec_u@_FillValue,rec_u)
      rec_v         = where(t_u .le. t@t90 .and. t_u .ge. -t@t90 .and. t_v .le. t@t90 .and. t_v .ge. -t@t90, rec_v@_FillValue,rec_v)
      copy_VarCoords(u(0,:,:), rec_u)
      copy_VarCoords(v(0,:,:), rec_v)
      ; printVarSummary(opt)
      add_vc_dev(wks,plot,rec_u,rec_v,ranges,opt)
      ; vec = gsn_csm_vector(wks, rec_u, rec_v, resv)
      ; overlay(plot, vec)
  end if

    ;resc@cnLevels=cnLevels(type,:)
    ;rec_p=gsn_csm_contour(wks, rec, resc)
    ;overlay(ccr_p(a), rec_p)
    ; if(isatt(opt, "dotslon") .and. isatt(opt, "dotslat"))
    ;   resl=True
    ;   resl@gsLineColor= "tomato"
    ;   resl@gsLineThicknessF=8.0
    ;   str = unique_string("polyline")
    ;   plot(a)@$str$=gsn_add_polyline(wks, plot(a),opt@dotslon,opt@dotslat,resl)
    ; end if

    ; cnres           = True
    ; cnres@china     = True       ;draw china map or not
    ; cnres@river     = True       ;draw chan gjiang&huanghe or not
    ; cnres@province  = True       ;draw province boundary or not
    ; cnres@nanhai    = True       ;draw nanhai or not 
    ; cnres@diqu      = False       ; draw diqujie or not

    ; ;chinamap = add_china_map(wks,ccr_p(2*a),cnres);draw(ccr_p(a))
    ; ;frame(wks)
    ; delete([/X,tem0,tem1,over1,over0/])
  print("success!")
  if(get_res_value_keep(opt,"gsnDraw",True)) draw(plot) end if
  if(get_res_value_keep(opt,"gsnFrame",True)) frame(wks) end if
  return(plot)
end