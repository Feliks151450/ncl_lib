1undef("plot_ts") ; FX| plot_ts
  function plot_ts(wks,ts,opt)
  local rts,res_lines
  begin

  nyear = dimsizes(ts&year)
  rts   = True
    rts@tmYROn                      = get_res_value_keep(opt,"tmYROn",False)
    rts@tmXTOn                      = False
    rts@tmYLValues                  = get_res_value_keep(opt,"tmYLValues",ispan(-30,30,10)/10.)
    rts@minmax = get_res_value_keep(opt,"minmax",(/min(rts@tmYLValues),max(rts@tmYLValues)/))
  ; rts@gsnMaximize                 = True
    rts@gsnDraw                     = get_res_value_keep(opt,"gsnDraw",True)
    rts@gsnFrame                    = get_res_value_keep(opt,"gsnFrame",True)
    rts@vpYF                        = 0.8       ; the plot
    rts@vpXF                        = get_res_value_keep(opt,"vpXF",0.13)
    rts@vpWidthF                    = get_res_value_keep(opt,"vpWidthF",0.82)
    rts@vpHeightF                   = get_res_value_keep(opt,"vpHeightF",0.35)
  ; rts@gsnMaximize                 = True
    rts@xyDashPatterns              = (/0.,0.,0./)      ; make all lines solid
    rts@trXMinF                     = min(ts&year)-1
    rts@trXMaxF                     = get_res_value_keep(opt,"trXMaxF",max(ts&year)+1)
    rts@tmXBTickSpacingF            = get_res_value_keep(opt,"tmXBTickSpacingF",5.)
    rts@tmXBMode                    = get_res_value_keep(opt,"tmXBMode","Manual")
    rts@tmXBLabelStride              = get_res_value_keep(opt,"tmXBLabelStride",1)
    rts@tmXBTickStartF               = get_res_value_keep(opt,"tmXBTickStartF",rts@trXMinF)
    if(rts@tmXBMode .eq. "Explicit")
      rts@tmXBLabels = opt@tmXBLabels
      rts@tmXBValues = ispan(min(ts&year),max(ts&year),rts@tmXBTickSpacingF)
      print(rts@tmXBValues)
    end if
    rts@tmXMajorGrid                = False
    rts@tmXMajorGridLineDashPattern = 2
    rts@tmYLLabelDeltaF             = -0.6
    rts@tmXBLabelDeltaF             = -0.5
    rts@tmXBMajorLengthF            = 0.01
    rts@tmXBMinorOn                 = False
  ; rts@tmXUseBottom                = False
    rts@tmXBMajorOutwardLengthF     = 0.01
    rts@tmYLMajorOutwardLengthF     = 0.01
    rts@tmYLMajorLengthF            = 0.01
    rts@xyCurveDrawOrder = "postdraw"
    rts@tmBorderThicknessF = get_res_value_keep(opt,"tmBorderThicknessF",8)
    rts@tmXBMajorThicknessF = rts@tmBorderThicknessF
    rts@tmYLMajorThicknessF = rts@tmBorderThicknessF
    if(rts@tmYROn)
      rts = get_res_eq(opt,"tmYR")
      rts@tmYRMajorOutwardLengthF     = 0.01
      rts@tmYRMajorLengthF            = 0.01
      rts@tmYRMajorThicknessF = rts@tmBorderThicknessF
      rts@tmYUseLeft = False
      rts@tmYRMinorOn = False
      rts@tmYRMode = "Explicit"
      ; rts@tmYRLabels = sprintf("%0.1f", get_res_value_keep(opt,"tmYRLabels",rts@tmYRValues))
      rts@tmYRLabelsOn = True
      rts@tmYRLabelFontHeightF         = get_res_value_keep(opt, "tmLabelFontHeightF",0.03)
      rts@tmYRValues = get_res_value_keep(opt,"tmYRValues",ispan(-10,10,2)/10.)
    end if
  rts_rm                           = rts
    rts@tiXAxisOn = isatt(opt,"tiXAxisString")
    if(rts@tiXAxisOn)
      rts = get_res_eq(opt,"tiXAxis")
      ; rts@tiXAxisString = get_res_value_keep(opt,"tiXAxisString","")
      ; rts@tiXAxisOffsetYF = get_res_value_keep(opt,"tiXAxisOffsetYF",0.)
      rts@tiXAxisFontHeightF = get_res_value_keep(opt,"tiXAxisFontHeightF",0.03)
    end if

    rts@tiYAxisOn = isatt(opt,"tiYAxisString")
    if(rts@tiYAxisOn)
      rts = get_res_eq(opt,"tiYAxis")
      print(rts@tiYAxisString)
      ; rts@tiYAxisString = get_res_value_keep(opt,"tiYAxisString","")
      ; rts@tiYAxisOffsetYF = get_res_value_keep(opt,"tiYAxisOffsetYF",0.)
      rts@tiYAxisFontHeightF = get_res_value_keep(opt,"tiYAxisFontHeightF",0.03)
    end if
    rts@gsnXYBarChartBarWidth        = 0.70
    rts@gsnStringFontHeightF         = get_res_value_keep(opt, "gsnStringFontHeightF",0.04)
    rts@gsnStringFont = where(get_res_value_keep(opt,"gsnStringBold",False),22,21)
    rts@tmXBLabelFontHeightF         = get_res_value_keep(opt, "tmLabelFontHeightF",0.03)
    rts@tmXBLabelDeltaF              = 0.05

    rts@trYMinF                     = rts@minmax(0)      ; min value on x-axis
    rts@trYMaxF                     = rts@minmax(1)
    rts@tmYLMinorOn                  = False
    rts@tmYLLabelFontHeightF         = get_res_value_keep(opt, "tmLabelFontHeightF",0.03)
    rts@tmYLLabelDeltaF              = 0.05
    rts@tmYLLabelsOn                 = get_res_value_keep(opt,"tmYLLabelsOn",True)
    rts@tmYLMode                     = "Explicit"
    rts@tmYLLabels                   = sprintf("%0.1f", rts@tmYLValues)

    rts@lbLabelFontHeightF           = get_res_value_keep(opt,  "lbLabelFontHeightF",0.025)

      
    
    rts@addLeftString = get_res_value_keep(opt,"addLeftString","")
    rts@gsnLeftString                = rts@addLeftString+get_res_value_keep(opt,"gsnLeftString",ts@name)
    rts@gsnRightString               = get_res_value_keep(opt,"gsnRightString","")
    rts@gsnLeftStringOrthogonalPosF = get_res_value_keep(opt,"gsnLeftStringOrthogonalPosF",0.01)
    rts@gsnLeftStringParallelPosF = get_res_value_keep(opt,"gsnLeftStringParallelPosF",0)
    rts@gsnRightStringOrthogonalPosF = get_res_value_keep(opt,"gsnRightStringOrthogonalPosF",0.06)
    rts@xyLineColors                 = (/"tomato","forest green","forest green"/) ; colors chosen
    rts@xyMarkLineModes              = (/"Lines","MarkLines","Lines"/)
    rts@xyMarkers                    = (/16,16,16,16/)
    rts@xyMarkerColors               = rts@xyLineColors
    rts@xyMarkerSizeF                = get_res_value_keep(opt,"xyMarkerSizeF",0.012)
      if(get_res_value_keep(opt,"runcor",False))
        rts@tmXBMode   = "Explicit"
        rts@tmXBValues = opt@tmXBValues
        rts@tmXBLabels = opt@tmXBLabels
      end if
      if(isatt(opt, "Yref")) 
        rts@gsnYRefLine             = opt@Yref
        rts@gsnYRefLineDashPatterns = new(dimsizes(opt@Yref),integer)
        rts@gsnYRefLineDashPatterns = where(opt@Yref .eq. 0, 0, 1)
        rts@gsnYRefLineColors       = where(opt@Yref .eq. 0, "black", "dark slate gray")
        rts@gsnYRefLineThicknesses  = 8
      else 
        rts@gsnYRefLine      = 0
        rts@gsnYRefLineThicknessF  = 5
        rts@gsnYRefLineDashPatterns = 0
        rts@gsnYRefLineColor = 1
      end if

          ; rts@gsnYRefLine        =(/-opt@Yref,0.0,opt@Yref/);where(isatt(opt, "Yref"), opt@Yref, 0);
      ; rts@gsnYRefLineDashPatterns=(/1,0,1/)    ; line thicknesses 
      rts@gsnXYBarChart = get_res_value_keep(opt,"gsnXYBarChart",True)
      rts@tmYLLabelsOn = get_res_value_keep(opt,"tmYLLabelsOn",True)
      ; if(rts@tmYLLabelsOn)
      ;   rts@gsnLeftStringOrthogonalPosF = 0.01
      ;   rts@gsnRightStringOrthogonalPosF = 0.02
      ; else
      ;   rts@gsnLeftStringOrthogonalPosF = 0.03
      ;   rts@gsnRightStringOrthogonalPosF = 0.05
      ; end if
      rts@xyLineOpacities = (/1.,1,1/)
    if(rts@gsnXYBarChart)
      rts@gsnAboveYRefLineColor = "black"           ; above ref line fill red
      rts@gsnBelowYRefLineColor = "black"          ; below ref line fill blue
      rts@xyLineColors          = (/"black","black","black"/)
      rts@xyMarkLineModes       = (/"Lines","Lines","Lines"/)
      rts@xyLineThicknesses     = (/0.1,0.1,1/)      ; line thicknesses
      plot                      = gsn_csm_xy(wks,ts&year,ts,rts)
      ; if(dimsizes(ts1) .ne. 1)
      ;   rts@gsnXYBarChart = False
      ;   rts@xyLineColors       = (/"tomato","forest green","forest green"/) ; colors chosen
      ;   rts@xyMarkLineModes=(/"MarkLines","MarkLines","Lines"/)
      ;   rts@xyLineThicknesses  = (/5,5,5/)
      ;   rts@xyMarkers= (/16,16,16,16/)
      ;   plt = unique_string("xy")
      ;   plot@$plt$ = gsn_csm_xy(wks,ts1&year,ts1,rts)
      ;   overlay(plot, plot@$plt$)
      ;   ; draw(plot)
      ;   ; frame(wks)
      ; end if
    else
      ; if(dimsizes(ts1) .eq. 1)
      ; printVarSummary(opt)
      rts@xyLineColors(0) = get_res_value_keep(opt,"xyLineColor","tomato")
      ; printVarSummary(rts)
      rts@xyMarkLineMode = "MarkLines"
      rts@xyLineThicknessF = get_res_value_keep(opt,"xyLineThicknessF",10)
      ; rts@xyMarkerSizeF = 0.02
      if(get_res_value_keep(opt,"shading",False))
        rts@gsnAboveYRefLineColor = "tomato"
        ; rts@gsnAboveYRefLineColor := "#f0534e"
        ; rts@gsnBelowYRefLineColor = "#555aa7"
        rts@gsnBelowYRefLineColor = "forest green"
      end if
      rts@xyLineOpacities(0) = get_res_value_keep(opt,"xyLineOpacityF",1.)
      rts@xyLineThicknesses(0)     = get_res_value_keep(opt,"xyLineThicknessF",1)      ; line thicknesses
      plot = gsn_csm_xy(wks,ts&year,ts,rts)
        ; else
        ; plot = gsn_csm_xy(wks,ts0&year,(/ts0,ts1/),rts)
        ; draw(plot)
        ; frame(wks)
      ; end if
    end if

    if(isatt(opt,"name"))
      str0 = unique_string("text")
      res_text                    = True                  ; text mods desired
      res_text@txFontHeightF      = get_res_value_keep(opt,"txFontHeightF",0.02)            ; change text size
      res_text@txFontThicknessF   = 50
      res_text@txJust             = "CenterLeft"          ; text justification
      res_text@txFontColor        = rts@xyLineColor
      plot@$str0$ = gsn_add_text(wks,plot,opt@name,opt@LegendPos(0),opt@LegendPos(1),res_text);
    end if
    if(isatt(opt,"LinePos"))
      str1 = unique_string("polyline")
      res_lines                   = True                  ; polyline mods desired
      res_lines@gsLineDashPattern = 0.                    ; solid line
      res_lines@gsLineThicknessF  = 10.                    ; line thicker
      res_lines@gsLineColor       = rts@xyLineColor
      plot@$str1$ = gsn_add_polyline(wks,plot,opt@LinePos(:1),opt@LinePos(2:),res_lines);
    end if
    ; resb = True
    ; ; resb@gsnYRefLine = -10
    ; ; resb@gsnAboveYRefLineColor = "blue"
    ; resb@gsnDraw = False
    ; resb@gsnFrame = False
    ; resb@gsFillColor = "forest green"
    ; resb@gsFillOpacityF = 0.05
    ; resb@tfPolyDrawOrder = "PreDraw"
    ; ; resb@gs
    ; ; resb@trYMinF = min(rts@tmYLValues)      ; min value on x-axis
    ; ; resb@trYMaxF = max(rts@tmYLValues)
    ; ; tsb = ts0
    ; ; tsb = 10
    ; xx = (/1978,1978,1998.5,1998.5,1978/)
    ; yy = (/-3.0,3.0,3.0,-3.0,-3.0/)
    ; str = unique_string("xy")
    ; plot@$str$ = gsn_add_polygon(wks, plot, xx, yy, resb)
    ; overlay(plot,plot@$str$)
    ; str0 = unique_string("xy")
    ; resb@gsFillColor = "tomato"
    ; xx = xx+20.5
    ; plot@$str$ = gsn_add_polygon(wks, plot, xx, yy, resb)
    ; overlay(plot,plot@$str$)
      
    
  ;   if(isatt(opt,"rm") .and. opt@rm .gt. 0)then
  ;     ts_rm  = runave_Wrap(ts0, opt@rm, 0)
  ;     rts_rm = True
  ;     rts_rm@xyLineColor="black"
  ;     rts_rm@gsnYRefLine           = 0.    
  ;     rts_rm@tiYAxisString = ""         ; y-axis label
  ;     rts_rm@tiXAxisString =""
  ;     rts_rm@tmXBOn=False
  ;     rts_rm@tmYLOn=False
  ;     ; rts_rm@tmXBLabelFontHeightF = 0.02    ;font height of tick labels
  ;     ; rts_rm@tmYLLabelFontHeightF = 0.02   
  ;     rts_rm@gsnXYBarChart =False 
  ;     rts_rm@xyLineThicknessF =8.
  ;     plot_rm=gsn_csm_xy(wks,ts0&year,ts_rm,rts_rm)
  ;   end if
  
  ;   if(isatt(opt,"trend") .and. opt@trend)then
  ;     rc=regline(ts0&time,ts0)
  ;     xx=(/ts0&time(0),ts0&time(nyear-1)/)
  ;     print(xx)
  ;         xx = (/1997,2006/)
  
  ;     yy=(/ts0&time(0)*rc+rc@yintercept,ts0&time(nyear-1)*rc+rc@yintercept/)
  ;     print(yy)
  ;     res_lines                   = True                  ; polyline mods desired
  ;     res_lines@gsLineDashPattern = 0.                    ; solid line
  ;     res_lines@gsLineThicknessF  = 6.                    ; line thicker
  ;     res_lines@gsLineColor       = "green"
  ;     trend = gsn_add_polyline(wks,plot_rm,xx,yy,res_lines)
  ;   end if
  ;---------------------------Add plot legend-----------------------------------
    ; if(get_res_value_keep(opt,"legend",False))then
    ;   res_lines                   = True                  ; polyline mods desired
    ;   res_lines@gsLineDashPattern = 0.                    ; solid line
    ;   res_lines@gsLineThicknessF  = 8.                    ; line thicker
    ;   res_text                    = True                  ; text mods desired
    ;   res_text@txFontHeightF      = 0.035               ; change text size
    ;   res_text@txJust             = "CenterLeft"          ; text justification
    ;   res_text@txFontColor = "dodgerblue1"
    ;   name = opt@name0
    ;   pos = opt@pos0
    ;   res_lines@gsLineColor = get_res_value_keep(opt,"color0","dodgerblue1") 
    ;   res_text@txFontColor = get_res_value_keep(opt,"color0","dodgerblue1") 
    ;   plot0 = gsn_add_text(wks,plot,name,pos(0),pos(1),res_text); add text
    ;   name = opt@name1
    ;   pos = opt@pos1
    ;   res_lines@gsLineColor = get_res_value_keep(opt,"color1","dodgerblue1") 
    ;   res_text@txFontColor = get_res_value_keep(opt,"color1","dodgerblue1") 
    ;   plot1 = gsn_add_text(wks,plot,name,pos(0),pos(1),res_text); add text
      ; draw(plot)
      ; frame(wks)
      ; opt@nameL = where(isatt(ts0, "name"), ts0@name, "null")
      ; opt@nameR = where(isatt(ts1, "name"), ts1@name, "null")
      ; x = 0.03
      ; y = 0.9
      ; x_scale = max(ts0&time)-min(ts0&time)
      ; y_scale = opt@minmax(1)-opt@minmax(0)
      ; printVarSummary(ts0)
      ; xx = (/ts0&time(0)+x*x_scale,ts0&time(0)+(x+0.1)*x_scale/)
      ; yy = (/opt@minmax(0)+y*y_scale,opt@minmax(0)+y*y_scale/)
      ; text_pos = ts0&time(0)+(x+0.11)*x_scale

      ; u_dum11 = gsn_add_polyline(wks,plot,xx,yy,res_lines)              
      ; u_dum12 = gsn_add_text(wks,plot,opt@nameL,text_pos,yy(0),res_text)
      ; res_lines@gsLineColor       = "red"
      ; y = y-0.1
      ; yy = (/opt@minmax(0)+y*y_scale,opt@minmax(0)+y*y_scale/)
      ; u_dum21 = gsn_add_polyline(wks,plot,xx,yy,res_lines)              
      ; u_dum22 = gsn_add_text(wks,plot,opt@nameR,text_pos,yy(0),res_text)
      
    ;  end if
  return(plot)
  end