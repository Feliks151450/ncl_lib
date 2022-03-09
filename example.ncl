load "sub_toolbox.ncl"
load ".vscode/get_path.ncl"
load "indices.ncl"
begin
folder = "EAJ" ;"EAJ_plot"
fig = "pdf"
  ; fig@wkHeight = 3000
  ; fig@wkWidth = 3000
  ; fig@wkOrientation = "landscape"
  ; fig@wkPaperSize = "A0"
  fig@wkPaperWidthF = 20
  fig@wkPaperHeightF = 20
opt = True
opt@png = fig .eq. "png"
; opt@png = False
year = ispan(1979,2018,1)
year0 = ispan(1979,1998,1)
print(year0)
year1 = ispan(1999,2018,1)
EAJII = (/  2.133, -2.554,  3.548,  0.658,  0.798,  1.541,  2.563, -1.568,  1.252, -0.556,  0.375,  1.439, -2.453, -1.268,  2.373, -0.817, -0.315, -3.118, -2.638,  0.263, -9.170, -4.774, -1.269, -6.266,  8.917, -0.931, -0.252,  3.029, -1.156, -2.142,  8.570,  1.471, -0.520,  2.117,  6.032,  3.257, -5.824, -3.429,  1.955, -1.268/)    
    EAJII!0 = "year"
    EAJII&year = year
    EAJII@name = "EAJII"
    EAJII0 = dim_standardize_Wrap(EAJII({year0}),0)
    EAJII1 = dim_standardize_Wrap(EAJII({year1}),0)
; ILSST
    ; ; ;sources = (/"combined","HadISST","ERSSTv3","ERSSTv4","ERSSTv5","COBE","COBE2","OISST","Kaplan"/)
    ; type = 0
    ; type@months = 3
    ; type@year = year
    ; type@source = "combined"
    ; opt@weight=True
    ; opt@data=1
    ; opt@std = True  
    ; opt@detrend = False
    ; ; range = (/58,68,-28,-6/)
    ; range = (/56,68,-26,-0/)
    ; ILSST := areavg(type,range,opt)
    ; ILSST@name = "ILSST"
    ; copy_VarCoords(EAJII,ILSST)
    ; ILSST0 = dim_standardize_Wrap(ILSST({year0}),0)
    ; ILSST1 = dim_standardize_Wrap(ILSST({year1}),0)
    ; ; ; ILSST1 = (/ -1.137, -1.773, -0.821, -0.948,  2.027,  1.763, -0.052,  0.783,  0.046, -0.351,  0.539,  0.068,  0.482,  0.336,  1.070,  0.722, -1.652, -0.338,  0.161, -0.924/)
    ; ; ILSST1@name = "ILSST"
    ; ; copy_VarCoords(EAJII1,ILSST1)
    ; ; ;A
    ; ; ; NAT = (/ -0.180, -0.365, -0.067,  0.006,  0.326,  0.404,  0.309,  0.193,  0.241, -0.130,  0.068,  0.257,  0.119, -0.241,  0.215, -0.047, -0.534, -0.228, -0.099, -0.248/)
    ; ; ;B
    ; ; ; NAT = (/  0.354,  0.232, -0.327, -0.045, -0.360, -0.135, -0.002, -0.084, -0.247,  0.088,  0.008, -0.485, -0.445,  0.403, -0.226, -0.016,  0.134,  0.326,  0.347,  0.480/)
    ; ; ; C
    ; ; ; NAT = (/ -0.235, -0.174, -0.027, -0.048, -0.009,  0.090,  0.161,  0.033,  0.117,  0.015, -0.193,  0.577,  0.060, -0.157,  0.243, -0.204, -0.265,  0.038,  0.122, -0.145/)
    ; ; ; NAT = dim_standardize_Wrap(NAT,0)
    ; ; range = (/54,66,-18,0/)
    ; type@months := (/7,8/)
    ;     opt@dotslon = (/-18,-18,0,0,-18/)
    ; opt@dotslat = (/54,64,64,54,54/)
    ; ILSST_JA = areavg(type,range,opt)
    ; ILSST_JA@name = "ILSST_JA"
    ; copy_VarCoords(EAJII,ILSST_JA)
    ; ILSST_JA0 = dim_standardize_Wrap(ILSST_JA({year0}),0)
    ; ILSST_JA1 = dim_standardize_Wrap(ILSST_JA({year1}),0)





; FIG 1
    ; plot := new(6,graphic)
    ; opt@filename = localpath+folder+"/EAJII fig1"
    ; wks = gsn_open_wks(fig,opt@filename)
    ; type = 3
    ; type@level = 200
    ; type@months := (/7,8/)
    ; type@source = "jra55"
    ; opt@detrend = True
    ; range := (/31,53,80,135/)
    
    ; ;clim
    ; opt@data = 0
    ; type@year := ispan(1979,2018,1)
    ; tem_clim=predata(type,range,opt)
    ; ; printVarSummary(tem_clim)
    ; ; tem_clim@cnLevels = (/-10,-9,-8,-7.5,16,18,20,22/)
    ; tem_clim@cnLevels = (/-15,-14,-13,-12,22,24,26,28,30,32/)
    ; tem_clim@cnLineColor = "forest green"
    ; tem_clim@cnLineThicknessF = 10
    ; tem_clim@cnLineLabelsOn = False

    ; ;stddev
    ; opt@data = 1
    ; opt@vpHeightF = 0.4
    ; opt@gsnDraw = False

    ; type@year := ispan(1979,1998,1)
    ; tem0=predata(type,range,opt)
    ; tem_std0 = dim_stddev_n_Wrap(tem0, 0)

    ; type@year := ispan(1999,2018,1)
    ; tem1=predata(type,range,opt)
    ; tem_std1 = dim_stddev_n_Wrap(tem1, 0)

    ; tem_dif = tem_std1 - tem_std0
    ; tem_dif@cnLevels := (/0.5,1.0,1.5,2.0/);U300
    ; copy_VarCoords(tem_std0, tem_dif)

    ; F = ftest(tem_std0^2, 20, tem_std1^2, 20, 0)
    ; alpha = 100.*(1.-F)
    ; alpha@cnLevels = (/-99,-95,95,99/)
    ; alpha = where(tem_dif .lt. 0,0,alpha)
    ; copy_VarCoords(tem_std0, alpha)
    ; tem_dif = where(tem_dif .lt. 0,0,tem_dif)

    ; opt@gsnLeftString = "a";"(a) "+tem_std0@name+" SD Diff."
    ; opt@gsnStringBold = True
    ; opt@gsnLeftStringParallelPosF = -0.265
    ; opt@gsnLeftStringOrthogonalPosF = 0.1
    ; ; opt@gsnLeftString = "(a) "+tem_std0@name+" Clim"
    ; opt@gsnRightString = "";"P2-P1"
    ; opt@gsnStringFontHeightF = 0.04
    ; opt@tiXAxisString = "standard deviation (m s~S~-1~N~)"
    ; opt@tiXAxisOffsetYF = 0.02
    ; ; opt@tiYAxisFontHeightF = 0.02
    ; opt@tiYAxisString = "Latitude"
    ; opt@tiYAxisOffsetXF = 0.0255

    ; opt@lbLabelBarOn = False
    ; opt@tmYLLabelStride = 2
    ; opt@tmXBLabelStride = 1
    ; opt@tmYLTickSpacingF = 3
    ; opt@dots = True
    ; ; opt@dotslat = (/36.25,42.5,42.5,36.25,36.25/)
    ; ; opt@dotslon = (/90.,90,120,120,90/)
    ; opt@dotslat = (/38.75,43.75,43.75,38.75,38.75/)
    ; opt@dotslon = (/90.,90,120,120,90/)
    ; opt@dotscolor = "tomato"
    ; opt@dotsLineThicknessF := 15.
    ; opt@test = True
    ; opt@lbLabelBarOn = True
    ; opt@lbOrientation = "Horizontal"
    ; opt@lbStyle = "TriangleHighEnd"
    ; opt@vpWidthF = 0.6
    ; opt@vpHeightF = 0.3
    ; opt@pmLabelBarOrthogonalPosF = 0.2
    ; opt@tmLabelFontHeightF = 0.028

    ; opt@lbLabelFontHeightF = 0.025
    ; ; opt@lbTitleString = "ms~S~-1~B~"
    ; tem_dif@Colors = (/"#EEEEEE","#F6E9BC","#F1CD5C","#F0BF2A","#A57E1E"/)
    ; ; plot(0) = plot_cn(wks,tem_clim,tem_clim,0,range,opt)
    ; plot(0) = plot_cn(wks,tem_dif,tem_clim,alpha,range,opt)
    
    ; ;index-EAJII
    ; type = 3
    ; type@level = 200
    ; type@months = (/7,8/)
    ; type@source = "jra55"
    ; type@year := ispan(1979,2018,1)
    ; ; range = (/36.25,42.5,90,120/)
    ; range := (/38.75,43.75,90,120/)
    ; opt@data = 1
    ; opt@detrend = True
    ; opt@vpHeightF = 0.4
    ; opt@vpWidthF = 0.96
    ; opt@std = False
    ; opt@manual = False
    ; EAJII := areavg(type,range,opt)
    ; EAJII@name = "EAJII"
    ; EAJII0 = dim_standardize_Wrap(EAJII({year0}),0)
    ; EAJII1 = dim_standardize_Wrap(EAJII({year1}),0)
    ; output(EAJII)








    ; ; plt = new(2,"graphic")
    ; opt@gsnLeftString = "b";"(b) EAJII & PC1"
    ; opt@gsnLeftStringParallelPosF = -0.16
    ; opt@gsnRightString = ""
    ; opt@gsnDraw = False
    ; opt@gsnFrame = False
    ; opt@tmYLValues = ispan(-9,9,3)
    ; opt@tmYROn = True
    ; opt@dots = False
    ; ; opt@tmYUseLeft
    ; opt@minmax = (/-10,10/)
    ; opt@tmYRValues = ispan(-3,3,1)*dim_stddev(EAJII)
    ; opt@tmYRLabels = ispan(-3,3,1)
    ; opt@tiYAxisString = "EAJII index (m s~S~-1~N~)"
    ; opt@tiXAxisString = "Time (years) Std. dev."
    ; opt@tiXAxisOffsetYF = -0.005

    ; plot(1) = plot_ts(wks,EAJII,opt)

    ; rline = True
    ; rline@gsLineThicknessF = 12.
    ; rline@gsLineDashPattern = 1
    ; rline@gsLineColor = "dodgerblue1"
    ; line = gsn_add_polyline(wks, plot(1), (/1998.5,1998.5/), (/10,-10/), rline)
    
    
    ;EOF
    ; opt@detrend = False
    ; opt@data = 1
    ; type = 3
    ; type@level = 200
    ; ; type@year := ispan(1999,2018,1)
    ; type@year := ispan(1979,1998,1)
    ; ; type@year := ispan(1999,2018,1)
    ; type@months := (/7,8/)
    ; type@source = "jra55"
    ; ; range = (/20,55,80,130/)
    ; range = (/20,60,80,130/)
    ; X := predata(type,range,opt)

    ; ; md_print(X,True)
    ; opt@isPlot = False
    ; opt@neof = 2
    ; opt@jopt = 0
    ; opt@weight = True
    ; opt@reof = False
    ; opt@rev := (/-1, -1,1/)
    ; opt@name = "EAJ"
    ; opt@lbOrientation = "Vertical"
    ; opt@xcnLevels = (/-4,-3,-2,-1,1,2,3,4/)
    ; opt@minmax = (/-3,3/)
    ; opt@vpHeightF = 0.6
    ; EAJ0 := EOF(X,range,opt)
    ; EAJ0@units = ""
    ; pcvar0 = EAJ0@pcvar

    ; opt@rev = (/1, -1,1/)
    ; type@year := ispan(1999,2018,1)
    ; X := predata(type,range,opt)
    ; EAJ1 = EOF(X,range,opt)
    ; EAJ1@units = ""
    ; pcvar1 = EAJ1@pcvar

    ; localpath = readpath(1)
    ; ts0 := EAJ0(0,:)
    ; ts1 := EAJ1(0,:)   
    ; year0 := dimsizes(ts0&year)
    ; year1 := dimsizes(ts1&year)
    ; t0 = t_value(year0-2)
    ; t1 = t_value(year1-2)
    ; ;叠加PC1及相关系数
    ; rts = True
    ; rts@xyLineThicknessF = 15
    ; ts = ts0
    ; ts = (/ts0*dim_stddev(EAJII)/)
    ; plot_o = add_ts(wks,plot(1),ts,rts)
    ; ts := ts1
    ; ts = (/ts1*dim_stddev(EAJII)/)
    ; rts@xyLineColor = "forest green"
    ; plot_o = add_ts(wks,plot(1),ts,rts)

    ; name0 = "R1 = "+sprintf("%.2f",escorc(EAJII0,ts0))
    ; name1 = "R2 = "+sprintf("%.2f",escorc(EAJII1,ts1))
    ; pos0 = (/1983,-7/)
    ; pos1 = (/2004,-7/)
    ; res_text               = True                  ; text mods desired
    ; res_text@txFontHeightF = 0.035               ; change text size
    ; res_text@txJust        = "CenterLeft"          ; text justification
    ; res_text@txFontColor   = "tomato"
    ; plot_o = gsn_add_text(wks,plot(1),name0,pos0(0),pos0(1),res_text)
    ; res_text@txFontColor   = "forest green"
    ; plot_o = gsn_add_text(wks,plot(1),name1,pos1(0),pos1(1),res_text)
    ; range=(/10,65,70,160/)
    ; type = 3
    ; type@level = 200
    ; opt@data = 1
    ; opt@clim = True
    ; opt@lbLabelBarOn = False  
    ; opt@vpWidthF = 0.75
    ; opt@vpHeightF = 0.5
    ; opt@Scale = 1.0
    ; ; opt@gsnStringFontHeightF = 0.042
    ; ; opt@tmLabelFontHeightF = 0.033
    ; opt@tmYLTickSpacingF = 10
    ; opt@tmXBTickSpacingF = 10
    ; opt@tmXBLabelStride = 2
    ; delete(opt@lbStyle)
    ; ; opt@tmYLLabelFontHeightF = 0.03
    ; opt@tmYLLabelStride = 1

    ; opt@gsnLeftString = "";"EOF1 "+sprintf("%5.1f", pcvar0(0)) +"%"
    ; opt@addLeftString = "c"
    ; opt@gsnLeftStringParallelPosF = -0.21
    ; opt@gsnLeftStringOrthogonalPosF = 0.05
    ; opt@gsnRightString = ts0@units
    ; opt@addRightString = "";"P1 "
    ;     ; rts@gsnRightString = sprintf("%5.1f", pcvar1(0)) +"%"
    ; opt@tmYLLabelsOn = True
    ; ; opt@tmXBLabelsOn = False
    ; opt@tiYAxisString = "Latitude"
    ; opt@tiXAxisString = "Longitude"
    ; opt@tiXAxisOffsetYF = -0.03
    ; opt@dots = True
    ; opt@dotslat = (/38.75,43.75,43.75,38.75,38.75/)
    ; opt@dotslon = (/90.,90,120,120,90/)
    ; opt@dotsLineThicknessF = 13.
    ; plot(2) = reg(wks,ts0,type,range,opt)

    ; opt@addLeftString = "d"
    ; ; opt@gsnLeftStringParallelPosF = 0.
    ; opt@addRightString = "";"P2 "
    ; opt@tmXBLabelsOn = True
    ; opt@tmYLLabelsOn = True 
    ; opt@gsnLeftString = "";"EOF1 "+sprintf("%5.1f", pcvar1(0)) +"%"
    ; opt@lbLabelBarOn = True
    ; opt@pmLabelBarOrthogonalPosF = 0.02
    ; opt@pmLabelBarParallelPosF = 0.48
    ; opt@pmLabelBarHeightF = 0.52
    ; opt@lbOrientation = "Vertical"
    ; ; opt@tiYAxisString = ""
    ; opt@lbTitleString = "Correlation"
    ; plot(3) = reg(wks,ts1,type,range,opt)



    ; ; 降水
    ; ranges := (/18.5,45.5,98.5,124.5/)
    ; ; ranges = (/10,60,98.5 ,150/)
    ; type = 12
    ; type@months = (/7,8/)
    ; type@source = "NOAA Land"
    ; opt@Scale = (/0.25/)
    ; opt@gsnLeftString = "";"Prec"
    ; ; opt@addRightString = "P2 "

    ; opt@lbLabelBarOn = False
    ; ; opt@vpHeightF = 0.5
    ; ; opt@vpWidthF = 0.5
    ; opt@detrend = False
    ; opt@cnLineThicknessF = 10
    ; opt@gsnContourNegLineDashPattern = 2
    ; opt@vector = False
    ; ; opt@vcLevel = 850
    ; opt@vcRefMagnitudeF = 1.
    ; opt@dots = False
    ; opt@xReverseColors = True  
    ; ; opt@tmYLLabelStride = 1
    ; opt@tmXBLabelStride = 1
    ; opt@tmYLLabelsOn = True
    ; opt@tmXBTickSpacingF = 5
    ; opt@tmYLTickSpacingF = 5
    ; opt@vpHeightF = 0.65
    ; ; opt@gsnStringFontHeightF = 0.035
    ; ; opt@tmLabelFontHeightF = 0.03
    ; ; opt@gsnMajorLatSpacing = 5
    ; opt@clim = False
    ; opt@tmXBLabelsOn = True 
    ; opt@addLeftString = "e"
    ; opt@gsnLeftStringParallelPosF = -0.21
    ; opt@addRightString = "";"P1"
    ; opt@tiYAxisString = "Latitude"
    ; plot(4) = reg(wks,ts0,type,ranges,opt)
    ; opt@tmYLLabelsOn = True 
    ; opt@addLeftString = "f"
    ; ; opt@gsnLeftStringParallelPosF = 0.
    ; opt@lbLabelBarOn = True
    ; opt@pmLabelBarParallelPosF = 0.5
    ; opt@pmLabelBarHeightF = 0.65
    ; opt@addRightString = "";"P2"
    ; ; opt@tiYAxisString = ""
    ; plot(5) = reg(wks,ts1,type,ranges,opt)

    ; ; 水汽通量
    ; type = 19
    ; type@year := year
    ; type@level := (/1000,975,950,925,900,875,850,825,800,775,750,700,650,600,550,500,450,400,350,300,250,225,200,175,150,125,100/)
    ; ; range = (/15,70,85,140/)
    ; ; range = (/10,70,80,160/)
    ; range := (/15,50,98.5,130/)
    ; ; ranges = (/10,60,98.5 ,150/)
    ; ; range := (/19.5,45.5,97.5,124.5/)
    ; X := read_jra55(type,range,opt)
    ; q = dim_avg_n_Wrap(X,1)
    ; type = 3
    ; X := read_jra55(type,range,opt)
    ; U = dim_avg_n_Wrap(X,1)
    ; type = 4
    ; X := read_jra55(type,range,opt)
    ; V = dim_avg_n_Wrap(X,1)
    ; type = 20
    ; X := read_jra55(type,range,opt)
    ; SP = dim_avg_n_Wrap(X,1)
    ; uq = U*q
    ; vq = V*q
    ; copy_VarCoords(U,uq)
    ; copy_VarCoords(V,vq)
    ; uq_int = vibeta(uq&level, uq({year|:},{lat|:},{lon|:},{level|:}), 1, SP, 1000, 100)*10000.
    ; vq_int = vibeta(vq&level, vq({year|:},{lat|:},{lon|:},{level|:}), 1, SP, 1000, 100)*10000.
    ; copy_VarCoords(uq(:,0,:,:),uq_int)
    ; copy_VarCoords(vq(:,0,:,:),vq_int)
    ; ; uq_c = dim_avg_n_Wrap(uq,0)
    ; ; vq_c = dim_avg_n_Wrap(vq,0)
    ; ; SP_c = dim_avg_n_Wrap(SP,0)
    ; ; 1. 把散度垂直积分 
    ;     ; div = uv2dv_cfd(uq,vq,uq&lat,uq&lon,2);各层水汽通量散度
    ;     ; copy_VarCoords(U,div)
    ;     ; div_int = vibeta(uq&level, div({year|:},{lat|:},{lon|:},{level|:}), 1, SP, 1000, 100)*10000.
    ;     ; copy_VarCoords(div(:,0,:,:),div_int)
    ; ; 2. 把垂直积分的水汽通量求散度
    ;     ; div_int = uv2dv_cfd(uq_int,vq_int,uq_int&lat,uq_int&lon,2)
    ;     ; copy_VarCoords(uq_int,div_int)
    ; reg_uq0 := regCoef_n(ts0,uq_int({ts0&year},:,:),0,0) 
    ; reg_vq0 := regCoef_n(ts0,vq_int({ts0&year},:,:),0,0)
    ; reg_uq1 := regCoef_n(ts1,uq_int({ts1&year},:,:),0,0) 
    ; reg_vq1 := regCoef_n(ts1,vq_int({ts1&year},:,:),0,0)
    ; ; reg_div := regCoef_n(ts0,div_int({ts0&year},:,:)*100,0,0)
    ; ; reg_div := smth9_Wrap(reg_div, 0.5, 0.5, False)
    ; ; cor_div := escorc_n(ts0,div_int({ts0&year},:,:),0,0)
    ; copy_VarCoords(uq(0,0,:,:),reg_uq0)
    ; copy_VarCoords(vq(0,0,:,:),reg_vq0)
    ; copy_VarCoords(uq(0,0,:,:),reg_uq1)
    ; copy_VarCoords(vq(0,0,:,:),reg_vq1)
    ; ; copy_VarCoords(div_int(0,:,:),reg_div)
    ; ; copy_VarCoords(div_int(0,:,:),cor_div)
    ; t_u0 = onedtond(reg_uq0@tval,dimsizes(reg_uq0))
    ; t_v0 = onedtond(reg_vq0@tval,dimsizes(reg_vq0))
    ; t_u1 = onedtond(reg_uq1@tval,dimsizes(reg_uq1))
    ; t_v1 = onedtond(reg_vq1@tval,dimsizes(reg_vq1))
    ; ; reg_uq = where(abs(t_u) .ge. t@t80 .and. abs(t_v) .ge. t@t80, reg_uq, reg_uq@_FillValue)
    ; ; reg_vq = where(abs(t_u) .ge. t@t80 .and. abs(t_v) .ge. t@t80, reg_vq, reg_vq@_FillValue)
    ; ; reg_div@Scale = 1
    ; ; reg_div@cnLevels = (/-12,-9,-5.5,-4.5,-2.5,-1,1,2.5,4.5,5.5,9,12/)
    ; opt@nyear = dimsizes(EAJII0&year)
    ; opt@test = True
    ; opt@lbOrientation = "Horizontal"
    ; opt@tmYLLabelsOn = True
    ; opt@addLeftString = "(c) "
    ; opt@gsnLeftString = "Vapor Flux"
    ; opt@vpHeightF = 0.65
    ; opt@tmXBLabelStride = 1
    ; opt@tmYLTickSpacingF = 5
    ; opt@tmXBTickSpacingF = 5
    ; opt@vcRefMagnitudeF = 30000
    ; opt@vcLineArrowThicknessF = 6
    ; ; opt@gsnRightString = "P2"
    ; ; tval := onedtond(reg_div@tval,dimsizes(reg_div))
    ; ; copy_VarCoords(reg_div,tval)
    ; t = t_value(dimsizes(ts0)-2)
    ; ; cor_div@cnLevels = (/-t@r999,-t@r99,-t@r95,-t@r90,t@r90,t@r95,t@r99,t@r999/)
    ; ; plot(2) = plot_cn(wks,cor_div,reg_div,0,range,opt)
    ; reg_uq0 = where(abs(t_u0) .ge. t@t90 .or. abs(t_v0) .ge. t@t90, reg_uq0, reg_uq0@_FillValue)
    ; reg_vq0 = where(abs(t_u0) .ge. t@t90 .or. abs(t_v0) .ge. t@t90, reg_vq0, reg_vq0@_FillValue)
    ; copy_VarCoords(uq(0,0,:,:),reg_uq0)
    ; copy_VarCoords(vq(0,0,:,:),reg_vq0)

    ; t = t_value(dimsizes(ts0)-2)
    ; reg_uq1 = where(abs(t_u1) .ge. t@t90 .or. abs(t_v1) .ge. t@t90, reg_uq1, reg_uq1@_FillValue)
    ; reg_vq1 = where(abs(t_u1) .ge. t@t90 .or. abs(t_v1) .ge. t@t90, reg_vq1, reg_vq1@_FillValue)
    ; copy_VarCoords(uq(0,0,:,:),reg_uq1)
    ; copy_VarCoords(vq(0,0,:,:),reg_vq1)
    ; vc = add_vc(wks,plot(4),reg_uq0,reg_vq0,range,opt)
    ; vc = add_vc(wks,plot(5),reg_uq1,reg_vq1,range,opt)
    ; resp = True
    ; resp@gsnPanelLabelBar = False 
    ; resp@lbOrientation = "Horizontal"
    ; resp@lbBoxLineColor = "white"
    ; resp@lbBoxLineThicknessF = 25
    ; resp@lbLabelFontHeightF = 0.016
    ; resp@gsnPanelScalePlotIndex = 2
    ; resp@lbBoxEndCapStyle = "TriangleBothEnds"
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
    ; resp@gsnPanelYF := (/0.96,0.96,0.68,0.68,0.36,0.36/)
    ; resp@gsnPanelXF := (/0.08,0.46,0.08,0.55,0.08,0.55/)
    ; gsn_panel(wks,plot,(/3,2/),resp)
; FIG 2
    ; plot := new(2,graphic)
    ; optreg                    = True
    ; optreg@detrend            = False
    ; optreg@gsnPanelLabelBar   = True
    ; optreg@lbLabelBarOn       = False 
    ; optreg@lbOrientation = "vertical"
    ; optreg@pmLabelBarOrthogonalPosF = 0.01
    ; optreg@pmLabelBarParallelPosF = 0.48
    ; optreg@pmLabelBarHeightF = 0.57
    ; optreg@Scale              = 5
    ; optreg@tmLabelFontHeightF = 0.03
    ; optreg@tmYLLabelStride    = 1
    ; optreg@vcRefMagnitudeF    = 0.8
    ; optreg@vpHeightF          = 0.5
    ; optreg@vpWidthF           = 1.41
    ; optreg@year               = ispan(1978, 2019, 1)
    ; optreg@gsnStringFontHeightF = 0.04
    ; optreg@tmXBTickSpacingF = 30
    ; optreg@tmXBLabelStride = 1
    ; optreg@vcRefAnnoOrthogonalPosF = -1.0
    ; optreg@vcRefAnnoFontHeightF = 0.01
    ; optreg@png = opt@png
    ; ranges                    = (/10,75,-60,180/)
    ; optreg@addRightString = ""
    ; optreg@gsnRightString = ""
    ; optreg@addLeftString = "a"
    ; optreg@tmXBLabelsOn = True
    ; optreg@gsnLeftString = "";"EAJII reg. WAF & H300" 
    ; optreg@gsnLeftStringParallelPosF = -0.13
    ; optreg@gsnDraw = False
    ; optreg@gsnFrame = False
    ; optreg@lbBoxLineThicknessF = 15
    ; optreg@tiYAxisString = "Latitude"
    ; optreg@tiYAxisOffsetXF = 0.033
    ; optreg@tiXAxisString = "Longitude"
    ; optreg@tiXAxisOffsetYF = -0.05
    ; wks = gsn_open_wks(fig,localpath+folder+"/EAJII fig2")

    ; type = 5
    ; type@level := 300
    ; type@months := (/7,8/)
    ; type@source = "jra55"
    ; optreg@gsnStringBold = True
    ; optreg@vcLineArrowColor = "firebrick1"
    ; plot(0) = reg_waf(wks,EAJII0,type,ranges,optreg)
    ; optreg@addLeftString = "b"
    ; plot(1) = reg_waf(wks,EAJII1,type,ranges,optreg)
    ; ts0 = EAJII0
    ; ts1 = EAJII1
    ; ind_h0 = ind(ts0 .ge.  0.5)
    ; ind_l0 = ind(ts0 .le. -0.5)
    ; ind_h1 = ind(ts1 .ge.  0.5)
    ; ind_l1 = ind(ts1 .le. -0.5)
    ; range                           = (/00,90,90,190/)
    ; reso = True
    ;   reso@cnLevelSelectionMode       = "ExplicitLevels"
    ;   reso@cnFillOn                   = False
    ;   reso@cnLinesOn                  = True
    ;   reso@cnLineThicknessF           = 30
    ;   reso@cnLineLabelsOn             = False
    ;   reso@cnLineLabelInterval        = 1
    ;   reso@cnLineLabelBackgroundColor = -1
    ;   reso@cnLineLabelFontThicknessF  = 20
    ;   reso@cnLineLabelFontHeightF     = 0.012
    ;   reso@cnLineLabelDensityF        = 1.
    ;   reso@cnLevelFlag                = "LineAndLabel"
    ;   reso@cnLineLabelFontColor       = "blue1"
    ;   reso@gsnFrame                   = False
    ;   reso@gsnDraw                    = False
    ;   reso@gsnLeftString              = ""
    ;   reso@gsnRightString             = ""
    ;   reso@cnInfoLabelOn              = False
    ;   reso@cnLabelDrawOrder           = "postdraw"
    ;   reso@tmXBLabelsOn               = False
    ; ;   reso@cnLineDrawOrder            = "postdraw"
    ;   range                           = (/00,90,90,190/)
    ;   reso@cnLevels                   = 5865
    ; type = 5
    ; type@level = 500
    ; type_l = type
    ; type_l@year := ts0&year(ind_l0)
    ; ; opt@data = 3
    ; ; tem_l = read_jra55(type_l,range,opt)
    ; tem_l = read_jra55(type_l,range,opt)
    ; if(dimsizes(type@months) .ne. 1)
    ;     l = dim_avg_n_Wrap(tem_l,1)
    ;     else l = tem_l end if
    ; WPSH_l = dim_avg_n_Wrap(l,0)
    ; reso@cnLineColor                = "royalblue1"
    ; plto = gsn_csm_contour(wks,WPSH_l,reso)
    ; overlay(plot(0),plto)

    ; type_l = type
    ; type_l@year := ts1&year(ind_l1)
    ; ; tem_l := read_jra55(type_l,range,opt)
    ; tem_l := read_jra55(type_l,range,opt)
    ; if(dimsizes(type@months) .ne. 1)
    ;     l := dim_avg_n_Wrap(tem_l,1)
    ;     else l = tem_l end if
    ; WPSH_l = dim_avg_n_Wrap(l,0)
    ; reso@cnLineColor                = "royalblue1"
    ; plto = gsn_csm_contour(wks,WPSH_l,reso)
    ; overlay(plot(1),plto)

    ; type_h = type
    ; type_h@year := ts0&year(ind_h0)
    ; ; tem_h = read_jra55(type_h,range,opt)
    ; tem_h = read_jra55(type_h,range,opt)
    ; if(dimsizes(type@months) .ne. 1)
    ;     h = dim_avg_n_Wrap(tem_h,1)
    ;     else h = tem_h end if
    ; WPSH_h = dim_avg_n_Wrap(h,0)
    ; reso@cnLineColor                = "firebrick"
    ; plto = gsn_csm_contour(wks,WPSH_h,reso)
    ; overlay(plot(0),plto)

    ; type_h = type
    ; type_h@year := ts1&year(ind_h1)
    ; ; tem_h := read_jra55(type_h,range,opt)
    ; tem_h := read_jra55(type_h,range,opt)
    ; if(dimsizes(type@months) .ne. 1)
    ;     h := dim_avg_n_Wrap(tem_h,1)
    ;     else h = tem_h end if
    ; WPSH_h = dim_avg_n_Wrap(h,0)
    ; reso@cnLineColor                = "firebrick"
    ; plto = gsn_csm_contour(wks,WPSH_h,reso)
    ; overlay(plot(1),plto)

    ; ind_h0 := ind(ts0 .ge. 0.5)
    ; ind_l0 := ind(ts0 .le. -0.5)
    ; ind_h1 := ind(ts1 .ge. 0.5)
    ; ind_l1 := ind(ts1 .le. -0.5)

    ; type@level = 150
    ; range                           = (/00,90,20,130/)
    ; reso@cnLevels := 14350
    ; reso@cnLineDashPattern = 14
    ; type_l := type
    ; type_l@year := ts0&year(ind_l0)
    ; ; tem_l := read_jra55(type_l,range,opt)
    ; tem_l := read_jra55(type_l,range,opt)
    ; if(dimsizes(type@months) .ne. 1)
    ;     l := dim_avg_n_Wrap(tem_l,1)
    ;     else l := tem_l end if
    ; SAH_l := dim_avg_n_Wrap(l,0)
    ; reso@cnLineColor                = "royalblue1"
    ; plto = gsn_csm_contour(wks,SAH_l,reso)
    ; overlay(plot(0),plto)

    ; type_l := type
    ; type_l@year := ts1&year(ind_l1)
    ; ; tem_l := read_jra55(type_l,range,opt)
    ; tem_l := read_jra55(type_l,range,opt)
    ; if(dimsizes(type@months) .ne. 1)
    ;     l := dim_avg_n_Wrap(tem_l,1)
    ;     else l := tem_l end if
    ; SAH_l := dim_avg_n_Wrap(l,0)
    ; reso@cnLineColor                = "royalblue1"
    ; plto = gsn_csm_contour(wks,SAH_l,reso)
    ; overlay(plot(1),plto)

    ; type_h := type
    ; type_h@year := ts0&year(ind_h0)
    ; ; tem_h := read_jra55(type_h,range,opt)
    ; tem_h := read_jra55(type_h,range,opt)
    ; if(dimsizes(type@months) .ne. 1)
    ;     h := dim_avg_n_Wrap(tem_h,1)
    ;     else h := tem_h end if
    ; SAH_h := dim_avg_n_Wrap(h,0)
    ; reso@cnLineColor                = "firebrick"
    ; plto = gsn_csm_contour(wks,SAH_h,reso)
    ; overlay(plot(0),plto)

    ; type_h := type
    ; type_h@year := ts1&year(ind_h1)
    ; ; tem_h := read_jra55(type_h,range,opt)
    ; tem_h := read_jra55(type_h,range,opt)
    ; if(dimsizes(type@months) .ne. 1)
    ;     h := dim_avg_n_Wrap(tem_h,1)
    ;     else h := tem_h end if
    ; SAH_h := dim_avg_n_Wrap(h,0)
    ; reso@cnLineColor                = "firebrick"
    ; plto = gsn_csm_contour(wks,SAH_h,reso)
    ; overlay(plot(1),plto)
    ; res_text = True
    ; res_text@txFontHeightF = 0.03
    ; res_text@txFont = 22
    ; res_text@txFontColor = "firebrick"
    ; plt_text = gsn_add_text(wks,plot(0),"SAH",76,29,res_text)
    ; plt_text = gsn_add_text(wks,plot(0),"WNPSH",156,27,res_text)
    ; plt_text = gsn_add_text(wks,plot(1),"SAH",76,29,res_text)
    ; plt_text = gsn_add_text(wks,plot(1),"WNPSH",156,27,res_text)
    ; resp = True
    ; resp@gsnPanelLabelBar = True 
    ; resp@lbOrientation = "Horizontal"
    ; resp@lbBoxLineColor = "white"
    ; resp@lbBoxLineThicknessF = 30
    ; resp@lbLabelFontHeightF = 0.018
    ; resp@gsnPanelYWhiteSpacePercent = 6.0
    ; resp@lbTitleString = "Geopotential Height anomaly (gpm)"
    ; resp@lbTitlePosition = "Bottom"
    ; resp@lbTitleFontHeightF = 0.018

    ; if(resp@lbOrientation .eq. "Vertical")
    ;     resp@pmLabelBarWidthF = 0.13
    ;     resp@pmLabelBarHeightF = 0.9
    ;     else 
    ;     resp@pmLabelBarHeightF = 0.1
    ;     resp@pmLabelBarWidthF = 0.8
    ;     resp@pmLabelBarOrthogonalPosF = -0.04
    ;     resp@pmLabelBarParallelPosF = -0.01
    ; end if
    ; gsn_panel(wks,plot,(/2,1/),resp)
; FIG 3
    ; plot := new(7,graphic)
    ; optreg                          = True
    ; optreg@detrend                  = False
    ; optreg@lbLabelBarOn             = False 
    ; optreg@lbOrientation            = "vertical"

    ; optreg@Scale                    = 5
    ; optreg@tmLabelFontHeightF       = 0.04
    ; optreg@tmYLLabelStride          = 1
    ; optreg@vcRefMagnitudeF          = 0.8
    ; optreg@vpHeightF                = 0.6
    ; optreg@vpWidthF                 = 1.3
    ; optreg@gsnStringFontHeightF     = 0.05
    ; optreg@tmXBTickSpacingF         = 20
    ; optreg@tmXBLabelStride          = 1
    ; optreg@lbLabelBarOn = True
    ; optreg@lbOrientation = "Vertical"

    ; optreg@vcRefAnnoOrthogonalPosF = -2.185
    ; ; optreg@cnLineThicknessF = 10
    ; optreg@lbBoxLineThicknessF = 13
    ; optreg@lbLabelFontHeightF = 0.05

    ; optreg@png = False 
    ; ranges                    = (/15,75,0,170/)
    ; optreg@tmXBLabelsOn = False
    ; fig@wkWidth = 3500
    ; fig@wkHeight = 3500
    
    ; type := 5
    ; type@source = "jra55"
    ; type@level = 300
    ; type@months = (/7,8/) 
    ; type@preyear = False

    ; fig@wkPaperWidthF = 30
    ; fig@wkPaperHeightF = 30
    ; wks = gsn_open_wks(fig,readpath(1)+folder+"/EAJII fig3")
    ; ; plot(0) = reg_waf(wks,EAJII1,type,ranges,optreg)
    ; ; a = reg(0,EAJII1,type,ranges,optreg)
    ; optreg@tmYLLabelsOn = True
    ; optreg@tmXBLabelsOn = True
    ; optreg@lbLabelBarOn = True 
    ;     optreg@lbOrientation = "Horizontal"
    ;     optreg@pmLabelBarOrthogonalPosF = 0.41
    ;     optreg@pmLabelBarParallelPosF   = 0.5
    ;     optreg@pmLabelBarHeightF = 0.2
    ;     optreg@pmLabelBarWidthF = 1.4
    ;     optreg@lbLabelFontHeightF = 0.04
    ;     optreg@lbBoxLineThicknessF = 15
    ;     optreg@lbTitleString = "Geopotential Height anomaly (gpm)"
    ;     ; optreg@lbTitleFontHeightF = 0.035
    ; optreg@vcRefAnnoOrthogonalPosF = -1.0
    ; optreg@addLeftString = "e"
    ; optreg@gsnLeftStringParallelPosF = -0.18
    ; optreg@gsnStringBold = True
    ; optreg@gsnLeftString = "";"ILSST reg. WAF & H300"
    ; optreg@addRightString = ""
    ; optreg@gsnRightString = ""
    ; optreg@tiYAxisString = "Latitude"
    ; optreg@tiYAxisOffsetXF = 0.015
    ; optreg@tiYAxisFontHeightF = 0.035
    ; optreg@tiXAxisString = "Longitude"
    ; optreg@tiXAxisOffsetYF = -0.03
    ; optreg@tiXAxisFontHeightF = 0.035
    ; optreg@tiXAxisOffsetYF = 0.097
    ; optreg@cnLineThicknessF = 8.
    ; plot(6) = reg_waf(wks,ILSST_JA1,type,ranges,optreg)
    ; ; b = reg(0,ILSST_JA1,type,ranges,optreg)
    ; ; pc = pattern_cor(a, b, 1.0, 0)
    ; ; print(pc)

    ; ;sources = (/"combined","HadISST","ERSSTv3","ERSSTv4","ERSSTv5","COBE","COBE2","OISST","Kaplan"/)
    ; type = 0
    ; type@source = "combined"
    ; type@months := (/3/)
    ; ; ranges = (/46,74,-50,10/)
    ; ranges = (/46,75,-52,22/)
    ;     ; ranges = (/2,72,-45,40/)
    ; opt@Scale = (/0.25/)
    ; opt@png = False 
    ; opt@gsnFrame = False
    ; opt@gsnDraw = False
    ; ; opt@addRightString = "P2 "
    ; opt@lbLabelBarOn = False
    ; opt@vpHeightF = 0.535
    ; opt@vpWidthF = 0.9
    ; opt@detrend = False
    ; opt@cnLineThicknessF = 12
    ; opt@gsnStringFontHeightF = 0.05
    ; opt@tmLabelFontHeightF = 0.04
    ; opt@tmXBLabelsOn = True 
    ; opt@tmYLLabelsOn = True 
    ; opt@tmXBOn = True 
    ; opt@tmYLTickSpacingF = 7
    ; opt@tmXBTickSpacingF = 15
    ; opt@tmXBLabelStride = 1
    ; opt@clim = False
    ; opt@dots = True
    ; opt@cnLinesOn = False
    ; ; opt@gsnLeftString = "SST"
    ; opt@gsnRightStringOrthogonalPosF = -0.2
    ; opt@gsnRightStringParallelPosF = 0.23
    ; ; opt@gsnRightStringParallelPosF = 0.25
    ; ; opt@dotslon = (/-26,-26,-12,-12,-26/)
    ; ; opt@dotslat = (/60,70,70,60,60/)
    ; opt@dotslon = (/-26,-26,-0,-0,-26/)
    ; opt@dotslat = (/56,68,68,56,56/)
    ; ; range = (/54,64,-20,0/)
    ; ; opt@dotslon = (/-18,-18,0,0,-18/)
    ; ; opt@dotslat = (/54,64,64,54,54/)
    ; opt@tmYLLabelStride = 1
    ; opt@gsLineThicknessF = 10
    ; opt@addRightString = ""
    ; opt@addLeftString = "a "
    ; opt@gsnLeftString = ""
    ; opt@gsnStringBold = True
    ; opt@gsnLeftStringParallelPosF = -0.25
    ; opt@tiYAxisString = "Latitude"
    ; opt@tiYAxisOffsetXF = 0.015
    ; opt@tiYAxisFontHeightF = 0.035
    ; opt@tiXAxisString = "Longitude"
    ; opt@tiXAxisFontHeightF = 0.035
    ; opt@tiXAxisOffsetYF = -0.03
    ; opt@cnFillColors = (/"#6CB650","#9BCE7F","#C1E0B8","#FFFFFF","#F6E9BC","#F1CD5C","#F0B525","#A57E1E"/)
    ; t = t_value(dimsizes(EAJII1)-2)
    ; opt@cnLevels := (/-t@r99,-t@r95,-t@r90,t@r90,t@r95,t@r99,t@r999/)
    ; ; opt@tiYAxisOffsetXF = -0.1
    ; ; opt@gsnRightString = ""
    ; ; delete(opt@gsnRightString)

    ; plot(0) = reg(wks,EAJII1,type,ranges,opt)
    ; type@months := (/4, 5, 6/)
    ; opt@tmYLOn = False
    ; opt@dots = False
    ; opt@tmYLLabelsOn = True
    ; opt@gsnLeftString = ""
    ; opt@addLeftString = ""
    ; delete(opt@tiYAxisString)
    ; ; plot(3) = reg(wks,EAJII1,type,ranges,opt)
    ; ; type@months := (/5,6/)
    ; ; opt@gsnRightStringParallelPosF = 0.17
    ; plot(1) = reg(wks,EAJII1,type,ranges,opt)
    ; type@months := (/7,8/)
    ; opt@dots = True
    ; opt@tmYLOn = False
    ; opt@tmXBOn = True
    ; opt@lbLabelBarOn = True  
    ;     opt@lbOrientation = "Vertical"
    ;     opt@lbTitleString = "Correlation"
    ; opt@pmLabelBarOrthogonalPosF = 0.05
    ; opt@pmLabelBarParallelPosF = .5
    ; opt@pmLabelBarHeightF = 0.7
    ; opt@pmLabelBarWidthF = 0.2
    ; opt@lbLabelFontHeightF = 0.04
    ; opt@gsnRightStringOrthogonalPosF = -0.65
    ; opt@tiXAxisOffsetYF = -0.008
    ; opt@gsnRightStringOrthogonalPosF = -0.35
    ; ; opt@dotslon = (/-18,-18,0,0,-18/)
    ; ; opt@dotslat = (/54,64,64,54,54/)
    ; ; opt@dotslon = (/-28,-28,-0,-0,-28/)
    ; ; opt@dotslat = (/54,68,68,54,54/)
    ; opt@dotsColor = "forest green"

    ; plot(2) = reg(wks,EAJII1,type,ranges,opt)
    ; delete(opt@tmBorderThicknessF)
    ; delete(opt@dotscolor)

    ; R0 = escorc(EAJII0,ILSST0)
    ; R1 = escorc(EAJII1,ILSST1)
    ; opt@isPlot = False
    ; opt@addLeftString = "b"
    ; opt@gsnLeftString = "";"EAJII & ILSST_Mar"; run_stddev"
    ; opt@gsnRightString = ""; "1979-2018"
    ; opt@barchart = True
    ; opt@tmYLValues = ispan(-3,3,1)
    ; opt@minmax := (/-3.1,3/)
    ; opt@gsnDraw = False
    ; opt@gsnFrame = False
    ; opt@vpWidthF = 1.3
    ; opt@vpHeightF = 0.6
    ; opt@vpXF = 0.05
    ; opt@tmLabelFontHeightF = 0.04
    ; opt@gsnStringFontHeightF = 0.05
    ; opt@png = False
    ; opt@tmXBLabelsOn = True 
    ; opt@tmYLLabelsOn = True  
    ; opt@tmXBTickSpacingF = 5
    ; opt@gsnLeftStringParallelPosF = -0.18
    ; opt@tiYAxisString = "Std. dev."
    ; opt@tiYAxisOffsetXF = 0.02
    ; ; opt@tiXAxisOffsetYF = -0.02
    ; opt@tiXAxisString = "Time (years)"
    ; opt@name = "EAJII"
    ; opt@LegendPos = (/1980,2.4/)    
    ; opt@txFontHeightF = 0.04
    
    ; plot(3) = plot_ts(wks,dim_standardize_Wrap(EAJII,0),opt)
    
    ; rts = True
    ; rts@gsnDraw = False
    ; rts@gsnFrame = False
    ; rts@xyMarkerSizeF = 0.025
    ; rts@xyLineThicknessF = 15
    ; rts@name = "ILSST_Mar"
    ; rts@LegendPos = (/1980,1.6/)
    ; rts@txFontHeightF = 0.04
    ; plot_o = add_ts(wks,plot(3),ILSST,rts)

    ; rline = True
    ; rline@gsLineThicknessF = 10.
    ; rline@gsLineDashPattern = 16
    ; rline@gsLineColor = "dodgerblue1"
    ; line0 = gsn_add_polyline(wks, plot(3), (/1998.5,1998.5/), (/10,-10/), rline)
    
    ; name0 = "R1 = "+sprintf("%.2f",R0)+" (p>0.10)"
    ; name1 = "R2 = "+sprintf("%.2f",R1)+" (p<0.01)"
    ; pos0 = (/1980,-2.5/)
    ; pos1 = (/2001,-2.5/)
    ; opt@txFontColor = "dodgerblue1"
    ; opt@txJust = "CenterLeft"
    ; opt@txFontHeightF = 0.04
    ; plot_r = gsn_add_text(wks,plot(3),name0,pos0(0),pos0(1),opt)
    ; plot_r = gsn_add_text(wks,plot(3),name1,pos1(0),pos1(1),opt)

    ; opt@addLeftString = "d"
    ; opt@tmYLLabelsOn = True
    ; R0 = escorc(EAJII0,ILSST_JA0)
    ; R1 = escorc(EAJII1,ILSST_JA1)
    ; opt@gsnLeftString = "";"EAJII & ILSST"; run_stddev"
    ; plot(4) = plot_ts(wks,dim_standardize_Wrap(EAJII,0),opt)
    ; rts@xyLineColor = "forest green"
    ; rts@name = "ILSST"
    ; plot_o = add_ts(wks,plot(4),ILSST_JA,rts)

    ; rline = True
    ; rline@gsLineThicknessF = 10.
    ; rline@gsLineDashPattern = 16
    ; rline@gsLineColor = "dodgerblue1"
    ; line1 = gsn_add_polyline(wks, plot(4), (/1998.5,1998.5/), (/10,-10/), rline)
    
    ; name0 = "R1 = "+sprintf("%.2f",R0)+" (p<0.05)"
    ; name1 = "R2 = "+sprintf("%.2f",R1)+" (p<0.01)"
    ; opt@txFontColor = "dodgerblue1"
    ; opt@txJust = "CenterLeft"
    ; opt@txFontHeightF = 0.04
    ; plot_r = gsn_add_text(wks,plot(4),name0,pos0(0),pos0(1),opt)
    ; plot_r = gsn_add_text(wks,plot(4),name1,pos1(0),pos1(1),opt)
    ; ; ranges=(/20,90,-80,160/)
    ; ; optreg = True
    ; ; optreg@with = 5
    ; ; optreg@level = 300
    ; ; optreg@months = (/7,8/)
    ; ; optreg@detrend = False
    ; ; optreg@Scale = 7
    ; ; optreg@vcRefMagnitudeF = 1.5
    ; ; optreg@year = ispan(1978, 2019, 1)
    ; ; optreg@vpHeightF = 0.3
    ; ; optreg@vpWidthF = 0.8
    ; ; optreg@lbLabelBarOn = True
    ; ; optreg@gsnPanelLabelBar = False
    ; ; optreg@tmXBLabelsOn = True
    ; ; optreg@addLeftString = "(a) "
    ; ; optreg@addRightString = "P2 "
    ; ; optreg@pmLabelBarParallelPosF = 0.5
    ; ; optreg@pmLabelBarOrthogonalPosF = 0.15
    ; ; optreg@pmLabelBarWidthF = 0.85
    ; ; optreg@pmLabelBarHeightF = 0.1
    ; ; optreg@lbLabelStringsMode = "integer"
    ; ; optreg@gsnStringFontHeightF = 0.03
    ; ; optreg@tmLabelFontHeightF = 0.022


    ; ts0 = EAJII1;ILSST1
    ; ts1 = ILSST1;ILSST_JA1

    ; ; type = 5
    ; ; type@source = "jra55"
    ; ; type@level := 300
    ; ; type@months := (/7,8/)
    ; ; ; wks = gsn_open_wks(fig,localpath+folder+"/WAF ILSST")
    ; ; ; plot(4) = reg_waf(wks,ts0,type,ranges,optreg)
    ; ; ; plot(1) = reg_waf(wks,ts1,ranges,optreg)
    ; ranges=(/17,70,0,170/)
    ; ; ranges = (/15,65,35,155/)
    ; ; opt@addRightString = "P2 "
    ; ; opt@addLeftString = "(g) "
    ; ; opt@gsnLeftString = "U200 linked to ILSST_Mar"
    ; type = 3
    ; type@source = "jra55"
    ; type@level = 200
    ; type@months := (/7,8/)
    ; opt@Scale = 0.8;*100
    ; opt@lbLabelBarOn = True  
    ; opt@lbOrientation = "Vertical"
    ; opt@lbLabelFontHeightF = 0.04
    ; opt@pmLabelBarHeightF = 0.41
    ; ; opt@vpWidthF = 1.4
    ; ; opt@vpHeightF = 0.8
    ; opt@detrend = False
    ; opt@tmYLLabelStride = 1
    ; opt@tmYLOn = True 
    ; opt@tmYLLabelsOn = False
    ; ; opt@cnLineThicknessF = 10
    ; opt@tmYLTickSpacingF = 10
    ; opt@tmXBTickSpacingF = 20
    ; ; opt@tmLabelFontHeightF = 0.022
    ; opt@pmLabelBarHeightF = 0.9
    ; opt@pmLabelBarWidthF = 0.15
    ; opt@pmLabelBarOrthogonalPosF = 0.025
    ; opt@pmLabelBarParallelPosF = 0.5
    ; opt@clim = False
    ; opt@dots = True
    ; opt@cnLinesOn = True  
    ; opt@dotslat := (/38.75,43.75,43.75,38.75,38.75/)
    ; opt@dotslon := (/90.,90,120,120,90/)
    ; opt@dotsLineThicknessF = 10.0
    ; opt@lbBoxLineThicknessF = 13
    ; delete(opt@cnLineThicknessF)
    ; delete(opt@gsnRightStringParallelPosF)
    ; delete(opt@gsnRightStringOrthogonalPosF)
    ; ; opt@dotslat = (/36.25,42.5,42.5,36.25,36.25/)
    ; ; opt@dotslon = (/90,90,120,120,90/)
    ; ; plot(8) = reg(wks,ts0,type,ranges,opt)
    ; ; a = reg(0,ts0,type,ranges,opt)
    ; opt@addLeftString = "c "
    ; opt@lbLabelBarOn = True 
    ; opt@lbOrientation = "Horizontal" 
    ; opt@lbBoxLineThicknessF = 15
    ; opt@pmLabelBarHeightF = 0.2
    ; opt@pmLabelBarWidthF = 1.4
    ; opt@pmLabelBarOrthogonalPosF = 0.4
    ; opt@lbTitleString = "Correlation"
    ; opt@gsnContourNegLineDashPattern = 14
    ; ; opt@pmLabelBarHeightF = 0.13
    ; opt@tmYLLabelsOn = True
    ; opt@gsnLeftString = "";"U200 linked to ILSST"
    ; opt@gsnLeftStringParallelPosF = -0.18
    ; opt@tiYAxisString = "Latitude"
    ; opt@tiYAxisOffsetXF = 0.018
    ; opt@tiXAxisString = "Longitude"
    ; opt@tiXAxisOffsetYF = 0.095
    ; opt@cnLineThicknessF = 8.
    ; opt@dotsColor = "tomato"
    ; plot(5) = reg(wks,ts1,type,ranges,opt)
    ; ; b = reg(0,ts1,type,ranges,opt)
    ; ; pc = pattern_cor(a, b, 1.0, 0)
    ; ; print(pc)

    ; resp = True
    ; resp@gsnPanelLabelBar = False  
    ; resp@lbOrientation = "Vertical"
    ; resp@lbBoxLineColor = "white"
    ; resp@lbBoxLineThicknessF = 15
    ; resp@lbLabelFontHeightF = 0.023
    ; resp@gsnPanelBottom = 0.01
    ; resp@gsnPanelRight = 0.8
    ; resp@gsnPanelYWhiteSpacePercent = 2
    ; resp@gsnPanelXWhiteSpacePercent = 5
    ; resp@gsnPanelScalePlotIndex = 1
    ; resp@gsnPanelRowSpec = True
    ; resp@gsnMaximize = False
    ; if(resp@lbOrientation .eq. "Horizontal")
    ;     resp@pmLabelBarWidthF = 0.13
    ;     resp@pmLabelBarHeightF = 0.9
    ;     else 
    ;     resp@pmLabelBarHeightF = 0.1
    ;     resp@pmLabelBarWidthF = 0.8
    ;     resp@pmLabelBarOrthogonalPosF = 0.01
    ; end if
    ; resp@gsnPanelYF = (/0.95,0.95,0.95,0.69,0.69,0.41,0.41/)
    ; resp@gsnPanelXF = (/0.08,0.3225,0.5651,0.08,0.53,0.08,0.53/)+0.05
    ; gsn_panel(wks,plot,(/3,2,2/),resp)
    ; print(escorc(ILSST1,ILSST_JA1))
; FIG S1

  ;       ; PDO = input_PDO(ispan(1979,2018,1),(/7,8/),True)
  ;       ;         PDO0 = dim_standardize_Wrap(PDO({year0}),0)
  ;   ;         PDO1 = dim_standardize_Wrap(PDO({year1}),0)
  ;   ; AMO_JA = input_AMO(ispan(1979,2018,1),(/7,8/),True)
  ;   ;         ; AMO0 = dim_standardize_Wrap(AMO({year0}),0)
  ;   ;         ; AMO1 = dim_standardize_Wrap(AMO({year1}),0)
  ;   ; AMO_Mar = input_AMO(ispan(1979,2018,1),3,True)
  ; f = readAsciiTable("AMO.txt",13,"float",0)
  ; AMO = f(:141,1:)
  ; year := ispan(1880,2021,1)
  ; month = ispan(1,12,1)
  ; year1d = ndtooned(conform_dims(dimsizes(AMO),year,0))*100
  ; month1d = ndtooned(conform_dims(dimsizes(AMO),month,1))
  ; time1d = ispan(1,142*12,1)
  ; AMO1d = ndtooned(AMO)
  ; AMO1d!0 = "year"
  ; AMO1d&year = time1d
  ; AMO1d@_FillValue = -999.9000  
  ; wks = gsn_open_wks(fig,readpath(1)+folder+"/EAJII fig S1")
  ; rts = True
  ; rts@tmLabelFontHeightF = 0.02
  ; rts@minmax = (/-1,1/)
  ; ; rts@minmax = (/-0.5,0.5/)
  ; rts@tmYLValues = fspan(-1., 1., 5)
  ; rts@tmXBTickSpacingF = 12*20
  ; rts@tmXBTickStartF = 1
  ; rts@tmXBTickEndF = 142*12
  ; rts@gsnXYBarChart = False
  ; rts@xyLineColor = "grey"
  ; rts@shading = True
  ; rts@tmXBMode = "Explicit"
  ; rts@xyLineOpacityF = 0
  ; rts@tmXBLabels = (/"1880","1900","1920","1940","1960","1980","2000","2020"/)
  ; rts@tiYAxisString = "SST (K)"
  ; rts@tiYAxisFontHeightF = 0.02
  ; rts@tiXAxisFontHeightF = 0.02
  ; rts@tiXAxisString = "Time (months)"
  ; plot = plot_ts(wks,AMO1d(:142*12-5),rts)
  ; plot = plot_ts(wks,AMO_de_ano,rts)
    ; rts = True
    ; rts@gsnDraw = False
    ; rts@gsnFrame = False
    ; rts@minmax = (/-2.5,2.5/)
    ; rts@tiYAxisString = "Std. dev."
    ; rts@tiYAxisFontHeightF = 0.025
    ; ; rts@tiYAxisOffsetXF = 0.01
    ; rts@tiXAxisString = "Time (years)"
    ; rts@tiXAxisFontHeightF = 0.025
    ; rts@tiXAxisOffsetYF = -0.01
    ; rts@vpXF = 0.18
    ; rts@vpWidthF = 0.8
    ; rts@tmLabelFontHeightF = 0.025
    ; wks_ts = gsn_open_wks(fig,readpath(1)+folder+"/AMO")
    ; plot = plot_ts(wks_ts,AMO_JA,rts)
    ;     res_text = True
    ;     res_text@txFontHeightF = 0.02
    ;     res_text@txFontThicknessF = 50
    ;     res_text@txJust = "CenterLeft"
    ;     res_text@txFontColor = "black"
    ;     plot_text = gsn_add_text(wks_ts,plot,"AMO July-August",1979,2.0,res_text)
    ; rts@xyLineThicknessF=20
    ; ; rts@xyMarkLineMode = "MarkLines"
    ; ; rts@xyMarkerSizeF = 0.015
    ; rts@name = "AMO March"
    ; rts@LegendPos = (/1979,1.4/)
    ; ; rts@LinePos = (/1980,1984,2.0,2.0/)
    ; ploto = add_ts(wks_ts,plot,AMO_Mar,rts)
    ; draw(plot)
    ; frame(wks_ts) 
; FIG S2
  ; plot := new(5,graphic)
  ; EAJII_e = new((/3,dimsizes(year)/),float)
  ; fig@wkPaperWidthF = 30
  ; fig@wkPaperHeightF = 30
  ; wks = gsn_open_wks(fig,readpath(1)+folder+"/EAJII fig S2")
  ; source = (/"jra55","ncep1","ncep2"/)
  ; item = (/"ERA-5","NCEP-1","NCEP-2"/)
  ; type = 3
  ;   type@level = 200
  ;   type@months := (/7,8/)
  ; opt = True
  ;   opt@detrend = True
  ;   opt@gsnStringBold = True
  ;   opt@gsnLeftStringParallelPosF = -0.3
  ;   opt@gsnLeftStringOrthogonalPosF = 0.1
  ;   opt@gsnStringFontHeightF = 0.04
  ;   opt@tiXAxisString = "Longitude"
  ;   ; opt@tiXAxisString = "standard deviation (m s~S~-1~N~)"
  ;   opt@tiXAxisOffsetYF = -0.03
  ;   ; opt@tiYAxisFontHeightF = 0.02
  ;   opt@tiYAxisString = "Latitude"
  ;   opt@tiYAxisOffsetXF = 0.0255 
  ;   opt@lbLabelBarOn = False
  ;   opt@tmXBLabelStride = 1
  ;   opt@tmXBTickSpacingF = 15
  ;   opt@tmYLLabelStride = 2
  ;   opt@tmYLTickSpacingF = 4
  ;   opt@dots = True
  ;   ; opt@dotslat = (/36.25,42.5,42.5,36.25,36.25/)
  ;   ; opt@dotslon = (/90.,90,120,120,90/)
  ;   opt@dotslat := (/38.75,43.75,43.75,38.75,38.75/)
  ;   opt@dotslon := (/90.,90,120,120,90/)
  ;   opt@dotscolor = "tomato"
  ;   opt@dotsLineThicknessF := 12.
  ;   opt@test = True
  ;   opt@lbLabelBarOn = False
  ;   opt@lbOrientation = "Horizontal"
  ;   opt@lbStyle = "TriangleHighEnd"
  ;   opt@vpWidthF = 0.6
  ;   opt@vpHeightF = 0.3
  ;   opt@pmLabelBarOrthogonalPosF = 0.2
  ;   opt@tmLabelFontHeightF = 0.028
  ;   opt@lbLabelFontHeightF = 0.025
  ;   opt@gsnLeftString = "a"
  ; do i = 0,2,1
  ;   range := (/30,58,77,140/)
  ;   type@source = source(i)
  ;   opt@gsnRightString = item(i)
  ;   opt@gsnRightStringOrthogonalPosF = -0.2
  ;   opt@gsnRightStringParallelPosF = 0.90
  ;   ; opt@gsnLeftString = item(i);"(a) "+tem_std0@name+" SD Diff."
  ;   ;clim
  ;   opt@data = 0
  ;   type@year := year
  ;   tem_clim := predata(type,range,opt)
  ;     ; tem_clim@cnLevels = (/-10,-9,-8,-7.5,16,18,20,22/)
  ;     tem_clim@cnLevels = (/-15,-14,-13,-12,22,24,26,28,30,32/)
  ;     tem_clim@cnLineColor = "forest green"
  ;     tem_clim@cnLineThicknessF = 10
  ;     tem_clim@cnLineLabelsOn = False

  ;   ;stddev
  ;   opt@data = 1
  ;   opt@vpHeightF = 0.4
  ;   opt@gsnDraw = False

  ;   type@year := year0
  ;   tem0 := predata(type,range,opt)
  ;   tem_std0 := dim_stddev_n_Wrap(tem0, 0)

  ;   type@year := year1
  ;   tem1 := predata(type,range,opt)
  ;   tem_std1 := dim_stddev_n_Wrap(tem1, 0)

  ;   tem_dif := tem_std1 - tem_std0


  ;   opt@mode = "stippling"
  ;   F := ftest(tem_std0^2, 20, tem_std1^2, 20, 0)
  ;   alpha := 100.*(1.-F)
  ;   alpha := where(tem_dif .lt. 0,0,alpha)
  ;   alpha@cnLevels = (/-99,-95,95,99/)
  ;   alpha@cnFillColors = (/"white","gray","gray","white","white"/)
  ;   copy_VarCoords(tem_std0, alpha)
  ;   tem_dif := where(tem_dif .lt. 0,0,tem_dif)
  ;   tem_dif@cnFillColors = (/"#EEEEEE","#F6E9BC","#F1CD5C","#F0BF2A","#A57E1E"/)
  ;   tem_dif@cnLevels := (/0.5,1.0,1.5,2.0/);U300
  ;   copy_VarCoords(tem_std0, tem_dif)
  ;   ; opt@lbTitleString = "ms~S~-1~B~"
  ;   ; plot(0) = plot_cn(wks,tem_clim,tem_clim,0,range,opt)
  ;   ; lat = tem_dif&lat
    
  ;   if (i .eq. 2) then
  ;     opt@lbLabelBarOn = True
  ;     opt@lbOrientation = "Vertical"
  ;     opt@pmLabelBarOrthogonalPosF = 0.05
  ;     opt@tiXAxisOffsetYF = 0.008
  ;     opt@lbTitleString = "standard deviation (m s~S~-1~N~)"
  ;     opt@lbTitleOffsetF = 0.1
  ;     opt@gsnRightStringOrthogonalPosF = -0.34
  ;   end if
  ;   plot(i) = plot_cn(wks,tem_dif,tem_clim,alpha,range,opt)
  ;   opt@tmYLOn = False
  ;   opt@gsnLeftString = ""
  ;   opt@tiYAxisString = ""

    
  ;   ;index-EAJII
  ;   type = 3
  ;     type@level = 200
  ;     ; type@months = (/7,8/)
  ;   ; type@source = "jra55"
  ;     type@year := year
  ;   ; range = (/36.25,42.5,90,120/)
  ;     range := (/38.75,43.75,90,120/)
  ;     opt@data = 1
  ;     opt@detrend = True
  ;     opt@vpHeightF = 0.4
  ;     ; opt@vpWidthF = 0.96
  ;     opt@std = False
  ;     opt@manual = False
  ;   EAJII_e(i,:) = areavg(type,range,opt)
  ; end do
  ; rts = True
  ;   rts@gsnDraw = False
  ;   rts@gsnFrame = False
  ;   rts@vpWidthF = 1.8
  ;   rts@vpHeightF = 0.6
  ;   rts@minmax = (/-11,10/)
  ;   rts@tmYLValues = ispan(-9,9,3)
  ;   rts@tmBorderThicknessF = 10
  ;   rts@gsnLeftString = "b"
  ;   rts@gsnStringBold = True
  ;   rts@gsnLeftStringParallelPosF = -0.1
  ;   rts@tiYAxisString = "EAJII index (m s~S~-1~N~)"
  ;   rts@tiYAxisOffsetXF = 0.022
  ;   rts@tiXAxisString = "Time (years)"
  ; plot(3) = plot_ts(wks,EAJII_e(0,:),rts)
  ; res_text = True
  ; res_text@txFontHeightF = 0.05
  ; ploto = gsn_add_text(wks,plot(3),"ERA-5",1981.3,-8.5,res_text)
  ; rline = True
  ;   rline@gsLineThicknessF = 12.
  ;   rline@gsLineDashPattern = 1
  ;   rline@gsLineColor = "dodgerblue1"
  ; line = gsn_add_polyline(wks, plot(3), (/1998.5,1998.5/), (/12,-12/), rline)
  ; rts@xyLineColor = "forest green"
  ; rts@xyMarkLineMode = "MarkLines"
  ; rts@xyLineThicknessF = 10
  ; rts@name = "NCEP-1"
  ; rts@LegendPos = (/1985,-8.5/)
  ; rts@txFontHeightF      = res_text@txFontHeightF
  ; plot_add_ts = add_ts(wks,plot(3),EAJII_e(1,:),rts)
  ; rts@xyLineColor = "tomato"
  ; rts@xyMarkLineMode = "Lines"
  ; rts@xyLineThicknessF = 10
  ; rts@LegendPos = (/1991.9,-8.5/)
  ; rts@name = "NCEP-2"
  ; plot_add_ts = add_ts(wks,plot(3),EAJII_e(2,:),rts)
  ; resp = True
  ; resp@gsnPanelXF = (/0.1,0.34,0.58,0.1/)
  ; resp@gsnPanelYF = (/0.85,0.85,0.85,0.55/)
  ; resp@gsnPanelRowSpec = True
  ; gsn_panel(wks,plot(0:3),(/3,1/),resp)

; FIG S3
  ; ts0=EAJII0
  ; ts1=EAJII1
  ; ranges = (/15,65,35,155/)
  ; plot = new(4,graphic)
  ; wks = gsn_open_wks(fig,readpath(1)+folder+"/EAJII fig S3")
  ; type = 3
  ;   type@level = 200
  ;   type@months = (/7,8/)
  ;   type@source = "jra55"
  ;   opt@png = False
  ;   opt@gsnDraw = False
  ;   opt@gsnFrame = False
  ;   opt@Scale = (/0.8/)
  ;   opt@addRightString = ""
  ;   opt@gsnRightString = ""
  ;   opt@gsnLeftString = ""
  ;   opt@addLeftString = "a"
  ;   opt@gsnStringBold = True
  ;   opt@gsnLeftStringParallelPosF = -0.22
  ;   opt@lbLabelBarOn = False
  ;   opt@vpHeightF = 0.45
  ;   opt@vpWidthF = 0.8
  ;   opt@detrend = False
  ;   opt@tmYLLabelStride = 1
  ;   opt@gsnContourNegLineDashPattern = 14
  ;   opt@cnLineThicknessF = 6
  ;   opt@gsnStringFontHeightF = 0.04
  ;   opt@tmBorderThicknessF = 8
  ;   opt@dots = True
  ;   opt@dotsLineThicknessF = 10
  ;   opt@dotslat := (/37.5,43.75,43.75,37.5,37.5/)
  ;   ; opt@dotslat = (/36.25,42.5,42.5,36.25,36.25/)
  ;   opt@dotslon := (/90,90,122.5,122.5,90,90,122.5/)
  ;   opt@clim = False
  ;   opt@tiYAxisString = "Latitude"
  ;   opt@tiYAxisOffsetXF = 0.025
  ;   opt@tiXAxisString = "Longitude"
  ;   opt@tiXAxisOffsetYF = -0.04
  ; plot(0) = reg(wks,ts0,type,ranges,opt)
  ;   opt@addLeftString = "b"
  ; plot(1) = reg(wks,ts1,type,ranges,opt)

  ; type = 3
  ;   opt@Scale = 0.8
  ;   opt@Orientation = "meridional"
  ;   opt@dots = False
  ;   ranges := (/15,65,90,122.5/)
  ;   ; opt@addRightString = "P1 "
  ;   opt@addLeftString = "c"
  ;   opt@gsnLeftString = ""
  ;   opt@tmXBLabelStride = 1
  ;   opt@tmYLLabelsOn = True
  ;   opt@clim = True
  ;   opt@climLineThicknessF = 10
  ;   opt@topo = True
  ;   opt@tiYAxisString = "Pressure level"
  ;   opt@tiXAxisString = "Latitude"
  ;   opt@tiXAxisOffsetYF = 0.0
  ; plot(2) = reg_ver(wks,ts0,type,ranges,opt)
  ;   pres = (/1000,975,950,925,900,875,850,825,800,775,750,700,650,600,550,500,450,400,350,300,250,225,200,175,150,125,100/)
  ;   plot_o = add_topo(wks,plot(2),ranges,pres,opt)
  ;   opt@addLeftString = "d"
  ; plot(3) = reg_ver(wks,ts1,type,ranges,opt)
  ;   plot_o = add_topo(wks,plot(3),ranges,pres,opt)

  ; resp = True
  ;   resp@gsnPanelLabelBar = True
  ;   resp@lbOrientation = "Horizontal"
  ;   resp@lbLabelFontHeightF = 0.015
  ;   resp@lbTitleString = "Correlation"
  ;   setLabelbarTitle(resp)
  ;   resp@lbBoxLineColor = "white"
  ;   resp@lbBoxLineThicknessF = 15

  ;   if(resp@lbOrientation .eq. "Vertical")
  ;     resp@pmLabelBarWidthF = 0.13
  ;     resp@pmLabelBarHeightF = 0.9
  ;     resp@gsnPanelBottom = 0.07
  ;     resp@pmLabelBarParallelPosF = -0.022
  ;     resp@gsnPanelYWhiteSpacePercent = 2.0
  ;   else 
  ;     resp@pmLabelBarHeightF = 0.1
  ;     resp@pmLabelBarWidthF = 0.9
  ;     resp@gsnPanelLeft = -0.01
  ;     resp@pmLabelBarOrthogonalPosF = 0.01
  ;     resp@pmLabelBarParallelPosF = 0.026
  ;     resp@gsnPanelYWhiteSpacePercent = 8.0
  ;     resp@gsnPanelXWhiteSpacePercent = 1.0
  ;   end if
  ; gsn_panel(wks,plot,(/2,2/),resp)
; FIG S4
  ; ;index-EAJII
  ; type = 3
  ;   type@level = 200
  ;   type@months = (/7,8/)
  ;   type@source = "ERA5"
  ;   type@year := year
  ;   ; range = (/36.25,42.5,90,120/)
  ;   range := (/38.75,43.75,90,120/)
  ;   opt@data = 1
  ;   opt@detrend = True
  ;   opt@vpHeightF = 0.4
  ;   ; opt@vpWidthF = 0.96
  ;   opt@std = False
  ;   opt@manual = False
  ; EAJII_ERA5 = areavg(type,range,opt)
  ; ts0 = dim_standardize_Wrap(EAJII_ERA5({year0}),0)
  ; ts1 = dim_standardize_Wrap(EAJII_ERA5({year1}),0)
  ; ranges = (/15,65,35,155/)
  ; plot = new(4,graphic)
  ; wks = gsn_open_wks(fig,readpath(1)+folder+"/EAJII fig S4")
  ; type = 3
  ;   type@level = 200
  ;   type@months = (/7,8/)
  ;   type@source = "ERA5"
  ;   opt@png = False
  ;   opt@gsnDraw = False
  ;   opt@gsnFrame = False
  ;   opt@Scale = (/0.8/)
  ;   opt@addRightString = ""
  ;   opt@gsnRightString = ""
  ;   opt@gsnLeftString = ""
  ;   opt@addLeftString = "a"
  ;   opt@gsnStringBold = True
  ;   opt@gsnLeftStringParallelPosF = -0.22
  ;   opt@lbLabelBarOn = False
  ;   opt@vpHeightF = 0.45
  ;   opt@vpWidthF = 0.8
  ;   opt@detrend = False
  ;   opt@tmYLLabelStride = 1
  ;   opt@gsnContourNegLineDashPattern = 14
  ;   opt@cnLineThicknessF = 6
  ;   opt@gsnStringFontHeightF = 0.04
  ;   opt@tmBorderThicknessF = 8
  ;   opt@dots = True
  ;   opt@dotsLineThicknessF = 10
  ;   opt@dotslat := (/37.5,43.75,43.75,37.5,37.5/)
  ;   ; opt@dotslat = (/36.25,42.5,42.5,36.25,36.25/)
  ;   opt@dotslon := (/90,90,122.5,122.5,90,90,122.5/)
  ;   opt@clim = False
  ;   opt@tiYAxisString = "Latitude"
  ;   opt@tiYAxisOffsetXF = 0.025
  ;   opt@tiXAxisString = "Longitude"
  ;   opt@tiXAxisOffsetYF = -0.04
  ; plot(0) = reg(wks,ts0,type,ranges,opt)
  ;   opt@addLeftString = "b"
  ; plot(1) = reg(wks,ts1,type,ranges,opt)

  ; type = 3
  ;   opt@Scale = 0.8
  ;   opt@Orientation = "meridional"
  ;   opt@dots = False
  ;   ranges := (/15,65,90,120/)
  ;   ; opt@addRightString = "P1 "
  ;   opt@addLeftString = "c"
  ;   opt@gsnLeftString = ""
  ;   opt@tmXBLabelStride = 1
  ;   opt@tmYLLabelsOn = True
  ;   opt@clim = True
  ;   opt@climLineThicknessF = 10
  ;   opt@topo = True
  ;   opt@tiYAxisString = "Pressure level"
  ;   opt@tiXAxisString = "Latitude"
  ;   opt@tiXAxisOffsetYF = 0.0
  ; plot(2) = reg_ver(wks,ts0,type,ranges,opt)
  ; plot_o = add_topo(wks,plot(2),ranges,type@levels,opt)
  ;   opt@addLeftString = "d"
  ; plot(3) = reg_ver(wks,ts1,type,ranges,opt)
  ; plot_o = add_topo(wks,plot(3),ranges,type@levels,opt)

  ; resp = True
  ;   resp@gsnPanelLabelBar = True
  ;   resp@lbOrientation = "Horizontal"
  ;   resp@lbBoxLineColor = "white"
  ;   resp@lbBoxLineThicknessF = 15
  ;   resp@lbLabelFontHeightF = 0.015
  ;   resp@lbTitleString = "Correlation"
  ;   setLabelbarTitle(resp)
  ;   if(resp@lbOrientation .eq. "Vertical")
  ;     resp@pmLabelBarWidthF = 0.13
  ;     resp@pmLabelBarHeightF = 0.9
  ;     resp@gsnPanelBottom = 0.07
  ;     resp@pmLabelBarParallelPosF = -0.022
  ;     resp@gsnPanelYWhiteSpacePercent = 2.0
  ;   else 
  ;     resp@pmLabelBarHeightF = 0.1
  ;     resp@pmLabelBarWidthF = 0.9
  ;     resp@gsnPanelLeft = -0.01
  ;     resp@pmLabelBarOrthogonalPosF = 0.01
  ;     resp@pmLabelBarParallelPosF = 0.026
  ;     resp@gsnPanelYWhiteSpacePercent = 8.0
  ;     resp@gsnPanelXWhiteSpacePercent = 1.0
  ;   end if
  ; gsn_panel(wks,plot,(/2,2/),resp)
; FIG S5
  ; index-EAJII
  ; type = 3
  ;   type@level = 200
  ;   type@months = (/7,8/)
  ;   type@source = "ERA5"
  ;   type@year := ispan(1979,2018,1)
  ;   ; range = (/36.25,42.5,90,120/)
  ; range := (/38.75,43.75,90,120/)
  ;   opt@data = 1
  ;   opt@detrend = True
  ;   opt@std = False
  ;   opt@manual = False
  ; EAJII := areavg(type,range,opt)
  ;   EAJII@name = "EAJII"
  ;   EAJII0 = dim_standardize_Wrap(EAJII({year0}),0)
  ;   EAJII1 = dim_standardize_Wrap(EAJII({year1}),0)
  ; ; output(EAJII)

  ; plot = new(3,"graphic")
  ; wks = gsn_open_wks(fig,readpath(1)+folder+"/EAJII fig S5")
  ;   opt@vpHeightF = 0.55
  ;   opt@vpWidthF = 1.69
  ;   opt@gsnLeftString = "";"(b) EAJII & PC1"
  ;   opt@addLeftString = "c"
  ;   opt@gsnStringBold = True
  ;   opt@gsnLeftStringParallelPosF = -0.11
  ;   opt@gsnRightString = ""
  ;   opt@gsnDraw = False
  ;   opt@gsnFrame = False
  ;   opt@tmYLValues = ispan(-9,9,3)
  ;   opt@tmYROn = True
  ;   opt@dots = False
  ;   ; opt@tmYUseLeft
  ;   opt@minmax = (/-10,10/)
  ;   opt@tmYRValues = ispan(-3,3,1)*dim_stddev(EAJII)
  ;   opt@tmYRLabels = ispan(-3,3,1)
  ;   opt@tiYAxisString = "EAJII index (m s~S~-1~N~)"
  ;   opt@tiYAxisOffsetXF = 0.025
  ;   opt@tiXAxisString = "Time (years)"
  ;   opt@tiXAxisOffsetYF = -0.01

  ; plot(2) = plot_ts(wks,EAJII,opt)

  ; res_YR = True
  ; res_YR@txFontHeightF = 0.03
  ; plot_yr = add_YRAxisString(wks,plot(2),"Std. dev",res_YR)

  ; rline = True
  ;   rline@gsLineThicknessF = 12.
  ;   rline@gsLineDashPattern = 1
  ;   rline@gsLineColor = "dodgerblue1"
  ; line = gsn_add_polyline(wks, plot(2), (/1998.5,1998.5/), (/10,-10/), rline)
    
    
  ; ;EOF
  ;   opt@detrend = False
  ;   opt@data = 1
  ; type = 3
  ;   type@level = 200
  ;   ; type@year := ispan(1999,2018,1)
  ;   type@year := ispan(1979,1998,1)
  ;   ; type@year := ispan(1999,2018,1)
  ;   type@months := (/7,8/)
  ;   type@source = "ERA5"
  ;   ; range = (/20,55,80,130/)
  ; range = (/20,60,80,130/)
  ; X := predata(type,range,opt)
  ;   opt@isPlot = False
  ;   opt@neof = 2
  ;   opt@jopt = 0
  ;   opt@weight = True
  ;   opt@reof = False
  ;   opt@rev := (/-1, -1,1/)
  ;   opt@name = "EAJ"
  ;   opt@lbOrientation = "Vertical"
  ;   opt@xcnLevels = (/-4,-3,-2,-1,1,2,3,4/)
  ;   opt@minmax = (/-3,3/)
  ;   opt@vpHeightF = 0.6
  ; EAJ0 := EOF(X,range,opt)
  ;   EAJ0@units = ""
  ;   pcvar0 = EAJ0@pcvar

  ;   opt@rev = (/1, -1,1/)
  ;   type@year := ispan(1999,2018,1)
  ; X := predata(type,range,opt)
  ; EAJ1 = EOF(X,range,opt)
  ;   EAJ1@units = ""
  ;   pcvar1 = EAJ1@pcvar

  ;   ts0 := EAJ0(0,:)
  ;   ts1 := EAJ1(0,:)   
  ;   year0 := dimsizes(ts0&year)
  ;   year1 := dimsizes(ts1&year)
  ;   t0 = t_value(year0-2)
  ;   t1 = t_value(year1-2)
  ;   ;叠加PC1及相关系数
  ;   rts = True
  ;   rts@xyLineThicknessF = 15
  ;   ts = ts0
  ;   ts = (/ts0*dim_stddev(EAJII)/)
  ;   plot_o = add_ts(wks,plot(2),ts,rts)
  ;   ts := ts1
  ;   ts = (/ts1*dim_stddev(EAJII)/)
  ;   rts@xyLineColor = "forest green"
  ;   plot_o = add_ts(wks,plot(2),ts,rts)

  ;   name0 = "R1 = "+sprintf("%.2f",escorc(EAJII0,ts0))
  ;   name1 = "R2 = "+sprintf("%.2f",escorc(EAJII1,ts1))
  ;   pos0 = (/1985,-7/)
  ;   pos1 = (/2006,-7/)
  ;   res_text               = True                  ; text mods desired
  ;     res_text@txFontHeightF = 0.04               ; change text size
  ;     res_text@txJust        = "CenterLeft"          ; text justification
  ;     res_text@txFontColor   = "tomato"
  ;   plot_o = gsn_add_text(wks,plot(2),name0,pos0(0),pos0(1),res_text)
  ;     res_text@txFontColor   = "forest green"
  ;   plot_o = gsn_add_text(wks,plot(2),name1,pos1(0),pos1(1),res_text)
    
    
  ;   range=(/10,65,70,160/)
  ;   type = 3
  ;   type@level = 200
  ;   opt@data = 1
  ;   opt@clim = True
  ;   opt@climLineThicknessF = 15.
  ;   opt@lbLabelBarOn = False  
  ;   opt@vpWidthF = 0.7
  ;   opt@vpHeightF = 0.5
  ;   opt@Scale = 1.0
  ;   ; opt@gsnStringFontHeightF = 0.042
  ;   ; opt@tmLabelFontHeightF = 0.033
  ;   opt@tmYLTickSpacingF = 10
  ;   opt@tmXBTickSpacingF = 10
  ;   opt@tmXBLabelStride = 2
  ;   delete(opt@lbStyle)
  ;   ; opt@tmYLLabelFontHeightF = 0.03
  ;   opt@tmYLLabelStride = 1

  ;   opt@gsnLeftString = "";"EOF1 "+sprintf("%5.1f", pcvar0(0)) +"%"
  ;   opt@addLeftString = "a"
  ;   opt@gsnStringBold = True
  ;   opt@gsnLeftStringFontHeightF = 0.04
  ;   opt@gsnLeftStringParallelPosF = -0.26
  ;   opt@gsnLeftStringOrthogonalPosF = 0.05
  ;   opt@gsnRightString = ts0@units
  ;   opt@addRightString = "";"P1 "
  ;       ; rts@gsnRightString = sprintf("%5.1f", pcvar1(0)) +"%"
  ;   opt@tmYLLabelsOn = True
  ;   ; opt@tmXBLabelsOn = False
  ;   opt@tiYAxisString = "Latitude"
  ;   opt@tiYAxisOffsetXF = 0.024
  ;   opt@tiXAxisString = "Longitude"
  ;   opt@tiXAxisOffsetYF = -0.04
  ;   opt@dots = True
  ;   opt@dotsColor = "tomato"
  ;   opt@dotslat := (/38.75,43.75,43.75,38.75,38.75/)
  ;   opt@dotslon := (/90.,90,120,120,90/)
  ;   opt@dotsLineThicknessF = 10.
  ;   opt@cnLineThicknessF = 8.
  ;   plot(0) = reg(wks,ts0,type,range,opt)

  ;   opt@addLeftString = "b"

  ;   ; opt@gsnLeftStringParallelPosF = 0.
  ;   opt@addRightString = "";"P2 "
  ;   opt@tmXBLabelsOn = True
  ;   opt@tmYLLabelsOn = True 
  ;   opt@gsnLeftString = "";"EOF1 "+sprintf("%5.1f", pcvar1(0)) +"%"
  ;   opt@lbLabelBarOn = True
  ;   opt@pmLabelBarOrthogonalPosF = 0.02
  ;   opt@pmLabelBarParallelPosF = 0.48
  ;   opt@pmLabelBarHeightF = 0.52
  ;   opt@lbOrientation = "Vertical"
  ;   ; opt@tiYAxisString = ""
  ;   opt@tiXAxisOffsetYF = -0.03
  ;   opt@lbTitleString = "Correlation"
  ;   plot(1) = reg(wks,ts1,type,range,opt)

  ; resp = True
  ; resp@gsnPanelRight = 0.85
  ; resp@gsnPanelRowSpec = True
  ; resp@gsnPanelXF = (/0.1,0.55,0.1/)
  ; resp@gsnPanelYF = (/0.9,0.9,0.55/)
  ; gsn_panel(wks,plot,(/2,1/),resp)

; FIG S6

  ; plot = new(3,"graphic")
  ; wks = gsn_open_wks(fig,readpath(1)+folder+"/EAJII fig S6")
  ;   opt@vpHeightF = 0.55
  ;   opt@vpWidthF = 1.69
  ;   opt@gsnLeftString = "";"(b) EAJII & PC1"
  ;   opt@addLeftString = "c"
  ;   opt@gsnStringBold = True
  ;   opt@gsnLeftStringParallelPosF = -0.11
  ;   opt@gsnRightString = ""
  ;   opt@gsnDraw = False
  ;   opt@gsnFrame = False
  ;   opt@tmYLValues = ispan(-9,9,3)
  ;   opt@tmYROn = True
  ;   opt@dots = False
  ;   ; opt@tmYUseLeft
  ;   opt@minmax = (/-10,10/)
  ;   opt@tmYRValues = ispan(-3,3,1)*dim_stddev(EAJII)
  ;   opt@tmYRLabels = ispan(-3,3,1)
  ;   opt@tiYAxisString = "EAJII index (m s~S~-1~N~)"
  ;   opt@tiYAxisOffsetXF = 0.025
  ;   opt@tiXAxisString = "Time (years)"
  ;   opt@tiXAxisOffsetYF = -0.01

  ; plot(2) = plot_ts(wks,EAJII,opt)

  ; res_YR = True
  ; res_YR@txFontHeightF = 0.03
  ; plot_yr = add_YRAxisString(wks,plot(2),"Std. dev",res_YR)

  ; rline = True
  ;   rline@gsLineThicknessF = 12.
  ;   rline@gsLineDashPattern = 1
  ;   rline@gsLineColor = "dodgerblue1"
  ; line = gsn_add_polyline(wks, plot(2), (/1998.5,1998.5/), (/10,-10/), rline)
    
    
  ;EOF
  ;   opt@detrend = False
  ;   opt@data = 1
  ; type = 3
  ;   type@level = 200
  ;   ; type@year := ispan(1999,2018,1)
  ;   type@year := ispan(1979,1998,1)
  ;   ; type@year := ispan(1999,2018,1)
  ;   type@months := (/7,8/)
  ;   type@source = "jra55"
  ; range := (/20,60,90,120/)
  ; X := predata_ver(type,range,opt)
  ; X_avg := dim_avg_n_Wrap(X,3)
  ;   opt@isPlot = False
  ;   opt@neof = 2
  ;   opt@jopt = 0
  ;   opt@weight = True
  ;   opt@reof = False
  ;   opt@rev := (/-1, -1,1/)
  ;   opt@name = "EAJ"
  ;   opt@lbOrientation = "Vertical"
  ;   opt@xcnLevels = (/-4,-3,-2,-1,1,2,3,4/)
  ;   opt@minmax = (/-3,3/)
  ;   opt@vpHeightF = 0.6
  ; EAJ0 := EOF(X_avg,range,opt)
  ;   EAJ0@units = ""
  ;   pcvar0 = EAJ0@pcvar

  ;   opt@rev = (/1, -1,1/)
  ;   type@year := ispan(1999,2018,1)
  ; X := predata_ver(type,range,opt)
  ; X_avg := dim_avg_n_Wrap(X,3)
  ; EAJ1 = EOF(X_avg,range,opt)
  ;   EAJ1@units = ""
  ;   pcvar1 = EAJ1@pcvar

  ;   ts0 := EAJ0(0,:)
  ;   ts1 := EAJ1(0,:)   
  ;   year0 := dimsizes(ts0&year)
  ;   year1 := dimsizes(ts1&year)
  ;   t0 = t_value(year0-2)
  ;   t1 = t_value(year1-2)
  ;   ;叠加PC1及相关系数
  ;   rts = True
  ;   rts@xyLineThicknessF = 15
  ;   ts = ts0
  ;   ts = (/ts0*dim_stddev(EAJII)/)
  ;   plot_o = add_ts(wks,plot(2),ts,rts)
  ;   ts := ts1
  ;   ts = (/ts1*dim_stddev(EAJII)/)
  ;   rts@xyLineColor = "forest green"
  ;   plot_o = add_ts(wks,plot(2),ts,rts)

  ;   name0 = "R1 = "+sprintf("%.2f",escorc(EAJII0,ts0))
  ;   name1 = "R2 = "+sprintf("%.2f",escorc(EAJII1,ts1))
  ;   pos0 = (/1985,-7/)
  ;   pos1 = (/2006,-7/)
  ;   res_text               = True                  ; text mods desired
  ;     res_text@txFontHeightF = 0.04               ; change text size
  ;     res_text@txJust        = "CenterLeft"          ; text justification
  ;     res_text@txFontColor   = "tomato"
  ;   plot_o = gsn_add_text(wks,plot(2),name0,pos0(0),pos0(1),res_text)
  ;     res_text@txFontColor   = "forest green"
  ;   plot_o = gsn_add_text(wks,plot(2),name1,pos1(0),pos1(1),res_text)
    
    
  ;   range=(/10,65,90,120/)
  ;   type = 3
  ;   type@level := 200
  ;   opt@data = 1
  ;   opt@clim = True
  ;   opt@climLineThicknessF = 15.
  ;   opt@lbLabelBarOn = False  
  ;   opt@vpWidthF = 0.7
  ;   opt@vpHeightF = 0.6
  ;   opt@Scale = 1.0
  ;   ; opt@gsnStringFontHeightF = 0.042
  ;   ; opt@tmLabelFontHeightF = 0.033
  ;   opt@tmYLTickSpacingF = 10
  ;   opt@tmXBTickSpacingF = 10
  ;   opt@tmXBLabelStride = 2
  ;   delete(opt@lbStyle)
  ;   ; opt@tmYLLabelFontHeightF = 0.03
  ;   opt@tmYLLabelStride = 1

  ;   opt@gsnLeftString = "";"EOF1 "+sprintf("%5.1f", pcvar0(0)) +"%"
  ;   opt@addLeftString = "a"
  ;   opt@gsnStringBold = True
  ;   opt@gsnLeftStringFontHeightF = 0.04
  ;   opt@gsnLeftStringParallelPosF = -0.26
  ;   opt@gsnLeftStringOrthogonalPosF = 0.05
  ;   opt@gsnRightString = ts0@units
  ;   opt@addRightString = "";"P1 "
  ;       ; rts@gsnRightString = sprintf("%5.1f", pcvar1(0)) +"%"
  ;   opt@tmYLLabelsOn = True
  ;   ; opt@tmXBLabelsOn = False
  ;   opt@tiYAxisString = "Pressure levels (hPa)"
  ;   opt@tiYAxisOffsetXF = 0.024
  ;   opt@tiXAxisString = "Longitude"
  ;   opt@tiXAxisOffsetYF = -0.01
  ;   opt@dots = True
  ;   opt@dotsColor = "tomato"
  ;   opt@dotslat := (/38.75,43.75,43.75,38.75,38.75/)
  ;   opt@dotslon := (/90.,90,120,120,90/)
  ;   opt@dotsLineThicknessF = 10.
  ;   opt@cnLineThicknessF = 8.
  ;   opt@Orientation = "meridional"
  ;   plot(0) = reg_ver(wks,ts0,type,range,opt)
  ;   plot_o = add_topo(wks,plot(0),range,type@levels,opt)

  ;   opt@addLeftString = "b"

  ;   ; opt@gsnLeftStringParallelPosF = 0.
  ;   opt@addRightString = "";"P2 "
  ;   opt@tmXBLabelsOn = True
  ;   opt@tmYLLabelsOn = True 
  ;   opt@gsnLeftString = "";"EOF1 "+sprintf("%5.1f", pcvar1(0)) +"%"
  ;   opt@lbLabelBarOn = True
  ;   opt@pmLabelBarOrthogonalPosF = 0.02
  ;   opt@pmLabelBarParallelPosF = 0.48
  ;   opt@pmLabelBarHeightF = 0.65
  ;   opt@lbOrientation = "Vertical"
  ;   ; opt@tiYAxisString = ""
  ;   opt@tiXAxisOffsetYF = -0.01
  ;   opt@lbTitleString = "Correlation"
  ;   plot(1) = reg_ver(wks,ts1,type,range,opt)
  ;   plot_o = add_topo(wks,plot(1),range,type@levels,opt)

  ; resp = True
  ; resp@gsnPanelRight = 0.85
  ; resp@gsnPanelRowSpec = True
  ; resp@gsnPanelXF = (/0.1,0.55,0.1/)
  ; resp@gsnPanelYF = (/0.93,0.93,0.5/)
  ; gsn_panel(wks,plot,(/2,1/),resp)
; FIG S7
  ; ; index-EAJII
  ; type = 3
  ;   type@level = 200
  ;   type@months = (/7,8/)
  ;   type@source = "ERA5"
  ;   type@year := ispan(1979,2018,1)
  ;   ; range = (/36.25,42.5,90,120/)
  ; range := (/38.75,43.75,90,120/)
  ;   opt@data = 1
  ;   opt@detrend = True
  ;   opt@std = False
  ;   opt@manual = False
  ; EAJII := areavg(type,range,opt)
  ;   EAJII@name = "EAJII"
  ;   EAJII0 = dim_standardize_Wrap(EAJII({year0}),0)
  ;   EAJII1 = dim_standardize_Wrap(EAJII({year1}),0)
  ; plot = new(3,"graphic")
  ; wks = gsn_open_wks(fig,readpath(1)+folder+"/EAJII fig S7")
  ;   opt@vpHeightF = 0.55
  ;   opt@vpWidthF = 1.69
  ;   opt@gsnLeftString = "";"(b) EAJII & PC1"
  ;   opt@addLeftString = "c"
  ;   opt@gsnStringBold = True
  ;   opt@gsnLeftStringParallelPosF = -0.11
  ;   opt@gsnRightString = ""
  ;   opt@gsnDraw = False
  ;   opt@gsnFrame = False
  ;   opt@tmYLValues = ispan(-9,9,3)
  ;   opt@tmYROn = True
  ;   opt@dots = False
  ;   ; opt@tmYUseLeft
  ;   opt@minmax = (/-10,10/)
  ;   opt@tmYRValues = ispan(-3,3,1)*dim_stddev(EAJII)
  ;   opt@tmYRLabels = ispan(-3,3,1)
  ;   opt@tiYAxisString = "EAJII index (m s~S~-1~N~)"
  ;   opt@tiYAxisOffsetXF = 0.025
  ;   opt@tiXAxisString = "Time (years)"
  ;   opt@tiXAxisOffsetYF = -0.01

  ; plot(2) = plot_ts(wks,EAJII,opt)

  ; res_YR = True
  ; res_YR@txFontHeightF = 0.03
  ; plot_yr = add_YRAxisString(wks,plot(2),"Std. dev",res_YR)

  ; rline = True
  ;   rline@gsLineThicknessF = 12.
  ;   rline@gsLineDashPattern = 1
  ;   rline@gsLineColor = "dodgerblue1"
  ; line = gsn_add_polyline(wks, plot(2), (/1998.5,1998.5/), (/10,-10/), rline)
    
    
  ; ;EOF
  ;   opt@detrend = False
  ;   opt@data = 1
  ; type = 3
  ;   type@level = 200
  ;   ; type@year := ispan(1999,2018,1)
  ;   type@year := ispan(1979,1998,1)
  ;   ; type@year := ispan(1999,2018,1)
  ;   type@months := (/7,8/)
  ;   type@source = "ERA5"
  ; range := (/20,60,90,120/)
  ; X := predata_ver(type,range,opt)
  ; X_avg := dim_avg_n_Wrap(X,3)
  ;   opt@isPlot = False
  ;   opt@neof = 2
  ;   opt@jopt = 0
  ;   opt@weight = True
  ;   opt@reof = False
  ;   opt@rev := (/-1, -1,1/)
  ;   opt@name = "EAJ"
  ;   opt@lbOrientation = "Vertical"
  ;   opt@xcnLevels = (/-4,-3,-2,-1,1,2,3,4/)
  ;   opt@minmax = (/-3,3/)
  ;   opt@vpHeightF = 0.6
  ; EAJ0 := EOF(X_avg,range,opt)
  ;   EAJ0@units = ""
  ;   pcvar0 = EAJ0@pcvar

  ;   opt@rev = (/1, -1,1/)
  ;   type@year := ispan(1999,2018,1)
  ; X := predata_ver(type,range,opt)
  ; X_avg := dim_avg_n_Wrap(X,3)
  ; EAJ1 = EOF(X_avg,range,opt)
  ;   EAJ1@units = ""
  ;   pcvar1 = EAJ1@pcvar

  ;   ts0 := EAJ0(0,:)
  ;   ts1 := EAJ1(0,:)   
  ;   year0 := dimsizes(ts0&year)
  ;   year1 := dimsizes(ts1&year)
  ;   t0 = t_value(year0-2)
  ;   t1 = t_value(year1-2)
  ;   ;叠加PC1及相关系数
  ;   rts = True
  ;   rts@xyLineThicknessF = 15
  ;   ts = ts0
  ;   ts = (/ts0*dim_stddev(EAJII)/)
  ;   plot_o = add_ts(wks,plot(2),ts,rts)
  ;   ts := ts1
  ;   ts = (/ts1*dim_stddev(EAJII)/)
  ;   rts@xyLineColor = "forest green"
  ;   plot_o = add_ts(wks,plot(2),ts,rts)

  ;   name0 = "R1 = "+sprintf("%.2f",escorc(EAJII0,ts0))
  ;   name1 = "R2 = "+sprintf("%.2f",escorc(EAJII1,ts1))
  ;   pos0 = (/1985,-7/)
  ;   pos1 = (/2006,-7/)
  ;   res_text               = True                  ; text mods desired
  ;     res_text@txFontHeightF = 0.04               ; change text size
  ;     res_text@txJust        = "CenterLeft"          ; text justification
  ;     res_text@txFontColor   = "tomato"
  ;   plot_o = gsn_add_text(wks,plot(2),name0,pos0(0),pos0(1),res_text)
  ;     res_text@txFontColor   = "forest green"
  ;   plot_o = gsn_add_text(wks,plot(2),name1,pos1(0),pos1(1),res_text)
    
    
  ;   range=(/10,65,90,120/)
  ;   type = 3
  ;   type@level := 200
  ;   opt@data = 1
  ;   opt@clim = True
  ;   opt@climLineThicknessF = 15.
  ;   opt@lbLabelBarOn = False  
  ;   opt@vpWidthF = 0.7
  ;   opt@vpHeightF = 0.6
  ;   opt@Scale = 1.0
  ;   ; opt@gsnStringFontHeightF = 0.042
  ;   ; opt@tmLabelFontHeightF = 0.033
  ;   opt@tmYLTickSpacingF = 10
  ;   opt@tmXBTickSpacingF = 10
  ;   opt@tmXBLabelStride = 2
  ;   delete(opt@lbStyle)
  ;   ; opt@tmYLLabelFontHeightF = 0.03
  ;   opt@tmYLLabelStride = 1

  ;   opt@gsnLeftString = "";"EOF1 "+sprintf("%5.1f", pcvar0(0)) +"%"
  ;   opt@addLeftString = "a"
  ;   opt@gsnStringBold = True
  ;   opt@gsnLeftStringFontHeightF = 0.04
  ;   opt@gsnLeftStringParallelPosF = -0.26
  ;   opt@gsnLeftStringOrthogonalPosF = 0.05
  ;   opt@gsnRightString = ts0@units
  ;   opt@addRightString = "";"P1 "
  ;       ; rts@gsnRightString = sprintf("%5.1f", pcvar1(0)) +"%"
  ;   opt@tmYLLabelsOn = True
  ;   ; opt@tmXBLabelsOn = False
  ;   opt@tiYAxisString = "Pressure levels (hPa)"
  ;   opt@tiYAxisOffsetXF = 0.024
  ;   opt@tiXAxisString = "Longitude"
  ;   opt@tiXAxisOffsetYF = -0.01
  ;   opt@cnLineThicknessF = 8.
  ;   opt@Orientation = "meridional"
  ;   plot(0) = reg_ver(wks,ts0,type,range,opt)
  ;   plot_o = add_topo(wks,plot(0),range,type@levels,opt)

  ;   opt@addLeftString = "b"

  ;   ; opt@gsnLeftStringParallelPosF = 0.
  ;   opt@addRightString = "";"P2 "
  ;   opt@tmXBLabelsOn = True
  ;   opt@tmYLLabelsOn = True 
  ;   opt@gsnLeftString = "";"EOF1 "+sprintf("%5.1f", pcvar1(0)) +"%"
  ;   opt@lbLabelBarOn = True
  ;   opt@pmLabelBarOrthogonalPosF = 0.02
  ;   opt@pmLabelBarParallelPosF = 0.48
  ;   opt@pmLabelBarHeightF = 0.65
  ;   opt@lbOrientation = "Vertical"
  ;   ; opt@tiYAxisString = ""
  ;   opt@tiXAxisOffsetYF = -0.01
  ;   opt@lbTitleString = "Correlation"
  ;   plot(1) = reg_ver(wks,ts1,type,range,opt)
  ;   plot_o = add_topo(wks,plot(1),range,type@levels,opt)
  ; resp = True
  ; resp@gsnPanelRight = 0.85
  ; resp@gsnPanelRowSpec = True
  ; resp@gsnPanelXF = (/0.1,0.55,0.1/)
  ; resp@gsnPanelYF = (/0.93,0.93,0.5/)
  ; gsn_panel(wks,plot,(/2,1/),resp)
; FIG S8
  ; plot = new(2,"graphic")
  ; wks = gsn_open_wks(fig,readpath(1)+folder+"/EAJII fig S8")
  ; type = 12
  ;   type@source = "GPCP"
  ;   type@months = (/7,8/)
  ; range := (/8.5,61.5,96,151.5/)
  ; rs8 = True
  ;   rs8@gsnDraw = False
  ;   rs8@gsnFrame = False
  ;   rs8@Scale = 0.4
  ;   rs8@smoothing = True
  ;   rs8@xReverseColors = True
  ;   rs8@vpWidthF = 0.6
  ;   rs8@vpHeightF = 0.6
  ;   setNatureMode(rs8)
  ;   rs8@tiXAxisString = "Longitude"
  ;   rs8@tiXAxisOffsetYF = -0.04
  ;   rs8@tiYAxisString = "Latitude"
  ;   rs8@lbLabelBarOn = False
  ;   rs8@tmLabelFontHeightF = 0.026
  ;   rs8@tmYLLabelStride = 1
  ;   rs8@cnLineThicknessF = 8
  ;   rs8@gsnLeftStringParallelPosF = -0.25
  ;   rs8@addLeftString = "a"
  ; plot(0) = reg(wks,ts0,type,range,rs8)
  ;   rs8@addLeftString = "b"
  ; plot(1) = reg(wks,ts1,type,range,rs8)
  ; resp = True;
  ;   resp@gsnPanelLabelBar = True
  ;   resp@gsnPanelXWhiteSpacePercent = 5
  ;   resp@lbOrientation = "Horizontal"
  ;   setLabelbar(resp)
  ;   setLabelbarTitle(resp)
  ;   resp@lbTitleString = "Correlation"
  ;   ; resp@lbBoxLineColor = "white"
  ;   ; resp@lbBoxLineThicknessF = 25
  ;   ; resp@lbLabelFontHeightF = 0.016
  ;   ; resp@gsnPanelScalePlotIndex = 2
  ;   ; resp@lbBoxEndCapStyle = "TriangleBothEnds"
  ;   ; ; resp@gsnFrame = False
  ;   ; ; resp@gsnPanelLeft = 0.1
  ;   ; ; resp@gsnPanelRight = 0.1
  ;   ; ; resp@gsnPanelTop = 1.1
  ;   ; ; resp@gsnPanelYWhiteSpacePercent = 16.0
  ;   ; resp@gsnPanelXWhiteSpacePercent = 5
  ;   ; ; resp@gsnMaximize = False
  ;   if(resp@lbOrientation .eq. "Vertical")
  ;       resp@pmLabelBarWidthF = 0.13
  ;       resp@pmLabelBarHeightF = 0.9
  ;       resp@gsnPanelBottom = 0.07
  ;       resp@pmLabelBarParallelPosF = -0.022
  ;       resp@gsnPanelYWhiteSpacePercent = 2.0
  ;       else 
  ;       resp@pmLabelBarHeightF = 0.09
  ;       resp@pmLabelBarWidthF = 0.7
  ;       resp@gsnPanelLeft = 0.01
  ;       resp@gsnPanelRight = 0.99
  ;       resp@pmLabelBarOrthogonalPosF = 0.001
  ;       resp@pmLabelBarParallelPosF = 0.04
  ;       resp@gsnPanelYWhiteSpacePercent = 6.0
  ;   end if
  ; gsn_panel(wks,plot,(/1,2/),resp)
; FIG S9
  ; plot = new(4,"graphic")
  ; wks = gsn_open_wks(fig,readpath(1)+folder+"/EAJII fig S9")
  ; type = 2
  ;   type@source = "jra55"
  ;   type@months = (/7,8/)
  ; range = (/10,60,95,150/)
  ; rs9 = True
  ;   rs9@gsnDraw = False
  ;   rs9@gsnFrame = False
  ;   rs9@Scale = 0.2
  ;   rs9@vpWidthF = 0.6
  ;   rs9@vpHeightF = 0.6
  ;   setNatureMode(rs9)
  ;   rs9@gsnLeftStringParallelPosF = -0.27
  ;   rs9@tiXAxisString = "Longitude"
  ;   rs9@tiYAxisString = "Latitude"
  ;   rs9@tiXAxisOffsetYF = -0.04
  ;   rs9@lbLabelBarOn = False
  ;   rs9@tmLabelFontHeightF = 0.026
  ;   rs9@tmYLLabelStride = 1
  ;   rs9@cnLineThicknessF = 6
  ;   rs9@smoothing = True
  ;   rs9@addLeftString = "a"
  ; plot(0) = reg(wks,ts0,type,range,rs9)
  ;   rs9@addLeftString = "b"
  ; plot(1) = reg(wks,ts1,type,range,rs9)
  ;   type@source = "ERA5"
  ;   rs9@addLeftString = "c"
  ; plot(2) = reg(wks,ts0,type,range,rs9)
  ;   rs9@addLeftString = "d"
  ; plot(3) = reg(wks,ts1,type,range,rs9)
  ; resp = True;
  ;   resp@gsnPanelLabelBar = True
  ;   resp@gsnPanelXWhiteSpacePercent = 5
  ;   resp@lbOrientation = "Horizontal"
  ;   setLabelbar(resp)
  ;   setLabelbarTitle(resp)
  ;   resp@lbTitleString = "Correlation"
  ;   ; resp@lbBoxLineColor = "white"
  ;   ; resp@lbBoxLineThicknessF = 25
  ;   ; resp@lbLabelFontHeightF = 0.016
  ;   ; resp@gsnPanelScalePlotIndex = 2
  ;   ; resp@lbBoxEndCapStyle = "TriangleBothEnds"
  ;   ; ; resp@gsnFrame = False
  ;   ; ; resp@gsnPanelLeft = 0.1
  ;   ; ; resp@gsnPanelRight = 0.1
  ;   ; ; resp@gsnPanelTop = 1.1
  ;   ; ; resp@gsnPanelYWhiteSpacePercent = 16.0
  ;   ; resp@gsnPanelXWhiteSpacePercent = 5
  ;   ; ; resp@gsnMaximize = False
  ;   if(resp@lbOrientation .eq. "Vertical")
  ;       resp@pmLabelBarWidthF = 0.13
  ;       resp@pmLabelBarHeightF = 0.9
  ;       resp@gsnPanelBottom = 0.07
  ;       resp@pmLabelBarParallelPosF = -0.022
  ;       resp@gsnPanelYWhiteSpacePercent = 2.0
  ;       else 
  ;       resp@pmLabelBarHeightF = 0.09
  ;       resp@pmLabelBarWidthF = 0.7
  ;       resp@gsnPanelLeft = 0.01
  ;       resp@gsnPanelRight = 0.99
  ;       resp@pmLabelBarOrthogonalPosF = 0.001
  ;       resp@pmLabelBarParallelPosF = 0.04
  ;       resp@gsnPanelYWhiteSpacePercent = 6.0
  ;   end if
  ; gsn_panel(wks,plot,(/2,2/),resp)
; FIG S10 垂直速度
  ; plot = new(4,"graphic")
  ; wks = gsn_open_wks(fig,readpath(1)+folder+"/EAJII fig S10")
  ; type = 7
  ;   type@source = "jra55"
  ;   type@months = (/7,8/)
  ; range = (/10,50,90,120/)
  ; rs10 = True
  ;   rs10@gsnDraw = True
  ;   rs10@gsnFrame = True
  ;   rs10@Scale = 0.2
  ;   rs10@vvScale = 500
  ;   rs10@cnLinesOn = False
  ;   rs10@vpWidthF = 0.6
  ;   rs10@vpHeightF = 0.6
  ;   setNatureMode(rs10)
  ;   rs10@tiXAxisString = "Latitude"
  ;   rs10@tiXAxisOffsetYF = -0.01
  ;   rs10@tiYAxisString = "Pressure levels (hPa)"
  ;   rs10@lbLabelBarOn = False
  ;   rs10@tmLabelFontHeightF = 0.026
  ;   rs10@tmYLLabelStride = 1
  ;   rs10@tmXBLabelStride = 1
  ;   rs10@cnLineThicknessF = 6
  ;   rs10@smoothing = True
  ;   rs10@Orientation = "meridional"
  ;   rs10@vector = True
  ;   rs10@vcRefMagnitudeF =3
  ;   rs10@vcLineArrowThicknessF =5
  ;   rs10@vcRefAnnoOrthogonalPosF = -1.119
  ;   rs10@gsnLeftStringParallelPosF = -0.3
  ;   rs10@addLeftString = "a"
  ; plot(0) = reg_ver(wks,EAJII0,type,range,rs10)
  ;   rs10@addLeftString = "b"
  ; plot(1) = reg_ver(wks,EAJII1,type,range,rs10)
  ;   type@source = "ERA5"
  ;   rs10@addLeftString = "c"
  ; plot(2) = reg_ver(wks,EAJII0,type,range,rs10)
  ;   rs10@addLeftString = "d"
  ; plot(3) = reg_ver(wks,EAJII1,type,range,rs10)
  ; resp = True;
  ;   resp@gsnPanelLabelBar = True
  ;   resp@gsnPanelXWhiteSpacePercent = 5
  ;   resp@lbOrientation = "Horizontal"
  ;   setLabelbar(resp)
  ;   setLabelbarTitle(resp)
  ;   resp@lbTitleString = "Correlation"
  ;   ; resp@lbBoxLineColor = "white"
  ;   ; resp@lbBoxLineThicknessF = 25
  ;   ; resp@lbLabelFontHeightF = 0.016
  ;   ; resp@gsnPanelScalePlotIndex = 2
  ;   ; resp@lbBoxEndCapStyle = "TriangleBothEnds"
  ;   ; ; resp@gsnFrame = False
  ;   ; ; resp@gsnPanelLeft = 0.1
  ;   ; ; resp@gsnPanelRight = 0.1
  ;   ; ; resp@gsnPanelTop = 1.1
  ;   ; ; resp@gsnPanelYWhiteSpacePercent = 16.0
  ;   ; resp@gsnPanelXWhiteSpacePercent = 5
  ;   ; ; resp@gsnMaximize = False
  ;   if(resp@lbOrientation .eq. "Vertical")
  ;       resp@pmLabelBarWidthF = 0.13
  ;       resp@pmLabelBarHeightF = 0.9
  ;       resp@gsnPanelBottom = 0.07
  ;       resp@pmLabelBarParallelPosF = -0.022
  ;       resp@gsnPanelYWhiteSpacePercent = 2.0
  ;       else 
  ;       resp@pmLabelBarHeightF = 0.09
  ;       resp@pmLabelBarWidthF = 0.7
  ;       resp@gsnPanelLeft = 0.01
  ;       resp@gsnPanelRight = 0.99
  ;       resp@pmLabelBarOrthogonalPosF = -0.05
  ;       resp@pmLabelBarParallelPosF = 0.04
  ;       resp@gsnPanelYWhiteSpacePercent = 6.0
  ;   end if
  ; gsn_panel(wks,plot,(/2,2/),resp)
; FIG S11 BBC&EAJII
  ; BBC = (/  0.508, -1.742,  1.458, -0.157,  0.042,  0.533, -0.502, -0.810,  1.412,  0.303,  1.291,  0.402, -1.233, -0.790,  1.046, -0.443,  0.217, -0.580, -1.979,  0.899, -0.165,  0.540, -1.270, -1.929,  0.565,  1.000,  0.609, -0.298,  1.015,  0.690, -0.229, -0.493, -1.048,  0.610,  0.691, -0.713, -1.899,  2.089,  0.699, -0.337/)
  ;   copy_VarCoords(EAJII,BBC)
  ;   BBC@name = "BBC"
  ;   BBC0 = dim_standardize_Wrap(BBC({year0}),0)
  ;   BBC1 = dim_standardize_Wrap(BBC({year1}),0)
  ;   copy_VarCoords(EAJII1,BBC1)
  ; R0 = escorc(EAJII0,BBC0)
  ; R1 = escorc(EAJII1,BBC1)
  ; plot = new(2,"graphic")
  ; wks = gsn_open_wks(fig,readpath(1)+folder+"/EAJII fig S11")
  ; rs11 = True
  ;   rs11@isPlot = False
  ;   rs11@addLeftString = "a"
  ;   setNatureMode(rs11)
  ;   rs11@tiYAxisString = "EAJII index (m s~S~-1~N~)"
  ;   rs11@tiXAxisString = "Time (years)"
  ;   rs11@tiXAxisOffsetYF = -0.01
  ;   rs11@gsnLeftStringParallelPosF = -0.12
  ;   rs11@barchart = True
  ;   rs11@tmYLValues = ispan(-3,3,1)
  ;   rs11@gsnDraw = False
  ;   rs11@gsnFrame = False
  ;   rs11@vpWidthF = 1.4
  ;   rs11@vpHeightF = 0.55
  ;   rs11@vpXF = 0.05
  ;   rs11@gsnStringFontHeightF = 0.04
  ;   rs11@tmLabelFontHeightF = 0.03
  ;   rs11@lbBoxLineThicknessF = 15
  ;   rs11@minmax = (/-10,10/)
  ;   rs11@tmYLValues = ispan(-9,9,3)
  ;   rs11@tmYROn = True
  ;   rs11@tmYRValues = ispan(-3,3,1)*dim_stddev(EAJII)
  ;   rs11@tmYRLabels = ispan(-3,3,1)
  ;   rs11@tmYRLabelFontColor = "tomato"
  ; plot(0) = plot_ts(wks,EAJII,rs11)
  ;   res_text = True
  ;   res_text@txFontHeightF = 0.03
  ;   res_text@txFontColor = rs11@tmYRLabelFontColor
  ;   ploto = add_YRAxisString(wks,plot(0),"BBC index",res_text)

  ; rts = True
  ;   rts@gsnDraw = False
  ;   rts@gsnFrame = False
  ;   rts@legend = False
  ;   rts@xyMarkerSizeF = 0.015
  ;   rts@xyLineThicknessF = 15
  ;   std = dim_stddev(EAJII)
  ;   BBC = (/std*BBC/)

  ; plot_o = add_ts(wks,plot(0),BBC,rts)
  ; rline = True
  ;   rline@gsLineThicknessF = 10.
  ;   rline@gsLineDashPattern = 16
  ;   rline@gsLineColor = "dodgerblue1"
  ; line = gsn_add_polyline(wks, plot(0), (/1998.5,1998.5/), (/10,-10/), rline)
    
  ; name0 = "R1 = "+sprintf("%.2f",R0)+" (p<0.01)"
  ; name1 = "R2 = "+sprintf("%.2f",R1)+" (p>0.10)"
  ; pos0 = (/1982,-8/)
  ; pos1 = (/2003,-8/)
  ;   opt@txFontColor = "dodgerblue1"
  ;   opt@txJust = "CenterLeft"
  ;   opt@txFontHeightF = 0.035
  ; plot_r = gsn_add_text(wks,plot(0),name0,pos0(0),pos0(1),opt)
  ; plot_r = gsn_add_text(wks,plot(0),name1,pos1(0),pos1(1),opt)

  ; ;BBC回归U200
  ; ts0=BBC0
  ; ts1=BBC1
  ; ranges = (/20,80,-60,160/)
  ; type = 3
  ;   type@months := (/7,8/)
  ;   type@level :=(/200/)
  ;   type@source = "jra55"
  ;   rs11@Scale = (/0.6/)
  ;   rs11@addLeftString = "b"
  ;   rs11@vpHeightF = 0.6
  ;   rs11@vpWidthF = 1.4
  ;   rs11@detrend = False  
  ;   rs11@cnLinesOn = True
  ;   rs11@lbLabelBarOn = True 
  ;   rs11@lbOrientation = "Vertical"
  ;   rs11@lbLabelFontHeightF = 0.03
  ;   rs11@tmYLLabelsOn = True
  ;   ; rs11@cnLineThicknessF = 15
  ;   rs11@tmYLLabelStride = 1
  ;   rs11@tmXBTickSpacingF = 30
  ;   rs11@tmXBLabelStride = 1
  ;   rs11@tiYAxisString = "Latitude"
  ;   rs11@tiXAxisString = "Longitude"
  ;   rs11@tiXAxisOffsetYF = -0.05
  ;   rs11@gsnContourNegLineDashPattern = 16
  ;   ; rs11@lbLabelBarOn = False
  ;   rs11@pmLabelBarOrthogonalPosF = 0.01
  ;   rs11@pmLabelBarParallelPosF = 0.5
  ;   rs11@pmLabelBarHeightF = 0.6
  ;   setLabelbarTitle(rs11)
  ;   rs11@lbTitleString = "geopotential height (gpm)"
  ;   rs11@vcRefMagnitudeF    = 0.8
  ;   rs11@vcMinMagnitudeF = 0.1
  ;   rs11@vcRefAnnoOrthogonalPosF = -1.0
 
  ;   rs11@clim = False
  ;   rs11@dots = False 
  ;   rs11@dotslat = (/38.75,43.75,43.75,38.75,38.75/)
  ;   rs11@dotslon := (/90.,90,120,120,90/)
  ;   ; rs11@cnLevels := (/-t@r99,-t@r95,-t@r90,t@r90,t@r95,t@r99/)
  ;   ; rs11@cnFillColors = (/"#407933","#72BF4F","#C1E0B8","#FFFFFF","#F6E9BC","#F0BF2A","#A57E1E"/)
  ;   ; rs11@dotslat = (/36.25,42.5,42.5,36.25,36.25/)
  ;   ; rs11@dotslon = (/90,90,120,120.,90,90,120/)
  ;   ; wks = gsn_open_wks(fig,localpath+folder+"/BBC_U300")
  ;   plot(1) = reg_waf(wks,BBC0,type,ranges,rs11)
  ;   ; plot(2) = reg_waf(wks,BBC1,type,ranges,rs11)
  ; resp =True
  ; resp@gsnPanelRight = 0.9
  ; resp@gsnPanelYWhiteSpacePercent =5.0
  ; gsn_panel(wks,plot,(/2,1/),resp)
; FIG S12
  ; plot = new((/7,3/),"graphic")
  ; wks = gsn_open_wks(fig,readpath(1)+folder+"/EAJII fig S12")
  ; sources = (/"combined","HadISST","ERSSTv3","ERSSTv4","ERSSTv5","COBE","COBE2","Kaplan"/)
  ; type = 0
  ; ranges = (/10,80,-70,14/)
  ; opt@Scale = (/0.25/)

  ;   ; opt@addRightString = "P2 "
  ;   opt@lbLabelBarOn = False
  ;   opt@vpHeightF = 0.6
  ;   opt@vpWidthF = 0.7
  ;   opt@detrend = False
  ;   opt@cnLineThicknessF = 12
  ;   opt@gsnLeftStringFontHeightF = 0.06
  ;   opt@gsnRightStringFontHeightF = 0.04
  ;   opt@tmLabelFontHeightF = 0.04
  ;   opt@tmXBLabelsOn = True 
  ;   opt@tmYLLabelsOn = True 
  ;   opt@tmXBOn = True 
  ;   opt@tmYLTickSpacingF = 15
  ;   opt@tmXBTickSpacingF = 20
  ;   opt@tmXBLabelStride = 1
  ;   opt@tmYLLabelStride = 1
  ;   opt@tmBorderThicknessF = 6
  ;   opt@clim = False

  ;   opt@cnLinesOn = False
  ;   ; opt@gsnLeftString = "SST"
  ;   opt@gsnRightStringOrthogonalPosF = -0.13
  ;   opt@gsnRightStringParallelPosF = 0.45
  ;   opt@gsnRightStringFontColor = "firebrick"
  ;   ; opt@gsnRightStringParallelPosF = 0.25
  ;   ; opt@dotslon = (/-26,-26,-12,-12,-26/)
  ;   ; opt@dotslat = (/60,70,70,60,60/)
  ;   opt@dots = False
  ;   opt@dotsLineThicknessF = 8
  ;   opt@dotslon = (/-26,-26,-0,-0,-26/)
  ;   opt@dotslat = (/56,68,68,56,56/)
  ;   ; range = (/54,64,-20,0/)
  ;   ; opt@dotslon = (/-18,-18,0,0,-18/)
  ;   ; opt@dotslat = (/54,64,64,54,54/)

  ;   opt@gsLineThicknessF = 10
  ;   opt@addRightString = ""
  ;   opt@addLeftString = "a "
  ;   opt@gsnLeftString = ""
  ;   opt@gsnStringBold = True
  ;   opt@gsnLeftStringParallelPosF = -0.3
  ;   opt@tiYAxisOffsetXF = 0.015
  ;   opt@tiYAxisFontHeightF = 0.035
  ;   opt@tiXAxisString = "Longitude"
  ;   opt@tiXAxisFontHeightF = 0.035
  ;   opt@tiXAxisOffsetYF = -0.03
  ;   opt@cnFillColors = (/"#6CB650","#9BCE7F","#C1E0B8","#FFFFFF","#F6E9BC","#F1CD5C","#F0B525","#A57E1E"/)
  ;   t = t_value(dimsizes(EAJII1)-2)
  ;   opt@cnLevels := (/-t@r99,-t@r95,-t@r90,t@r90,t@r95,t@r99,t@r999/)
  ;   ; opt@tiYAxisOffsetXF = -0.1
  ;   ; opt@gsnRightString = ""
  ;   ; delete(opt@gsnRightString)
  ;   item = (/"a","b","c","d","e","f","g","h"/)
  ; do i = 0, dimsizes(sources)-2
  ;   type@source = sources(i+1)
  ;   type@months := (/3/)
  ;   opt@addLeftString = item(i)
  ;   opt@tiYAxisString = "Latitude"
  ;   opt@tmYLOn = True
  ;   plot(i,0) = reg(wks,EAJII0,type,ranges,opt)
  ;   type@months := (/4, 5, 6/)
  ;   opt@tmYLOn = False
  ;   opt@tmYLLabelsOn = True
  ;   opt@gsnLeftString = ""
  ;   opt@addLeftString = ""
  ;   delete(opt@tiYAxisString)
  ;   ; plot(3) = reg(wks,EAJII1,type,ranges,opt)
  ;   ; type@months := (/5,6/)
  ;   ; opt@gsnRightStringParallelPosF = 0.17
  ;   plot(i,1) = reg(wks,EAJII0,type,ranges,opt)
  ;   type@months := (/7,8/)
  ;   opt@tmYLOn = False
  ;   opt@tmXBOn = True
  ;   opt@lbLabelBarOn = False  
  ;   opt@pmLabelBarOrthogonalPosF = 0.05
  ;   opt@pmLabelBarParallelPosF = .5
  ;   opt@pmLabelBarHeightF = 0.7
  ;   opt@pmLabelBarWidthF = 0.2
  ;   opt@lbLabelFontHeightF = 0.04
  ;   ; opt@gsnRightStringOrthogonalPosF = -0.65
  ;   ; opt@tiXAxisOffsetYF = -0.005
  ;   ; opt@gsnRightStringOrthogonalPosF = -0.35
  ;   ; opt@dotslon = (/-18,-18,0,0,-18/)
  ;   ; opt@dotslat = (/54,64,64,54,54/)
  ;   ; opt@dotslon = (/-28,-28,-0,-0,-28/)
  ;   ; opt@dotslat = (/54,68,68,54,54/)
  ;   opt@dotscolor = "forest green"
  ;   plot(i,2) = reg(wks,EAJII0,type,ranges,opt)
  ; end do
  ; resp = True
  ;   resp@gsnPanelXF = (/0.1,0.297,0.494,0.1,0.297,0.494,0.1,0.297,0.494,0.1,0.297,0.494/)
  ;   resp@gsnPanelYF = (/0.975,0.975,0.975,0.725,0.725,0.725,0.475,0.475,0.475,0.225,0.225,0.225/)
  ;   resp@gsnPanelBottom = 0.1
  ; gsn_panel(wks,ndtooned(plot(:3,:)),(/4,3/),resp)
  ;   ; resp@gsnPanelLabelBar = True
  ;   resp@gsnPanelXF := (/0.1,0.297,0.494,0.1,0.297,0.494,0.1,0.297,0.494/)
  ;   resp@gsnPanelYF := (/0.975,0.975,0.975,0.725,0.725,0.725,0.475,0.475,0.475/)
  ; gsn_panel(wks,ndtooned(plot(4:,:)),(/4,3/),resp)
; FIG S13
  ; plot = new((/8,3/),"graphic")
  ; wks = gsn_open_wks(fig,readpath(1)+folder+"/EAJII fig S13")
  ; sources = (/"combined","HadISST","ERSSTv3","ERSSTv4","ERSSTv5","COBE","COBE2","Kaplan"/)
  ; type = 0
  ; ranges = (/10,80,-70,14/)
  ; opt@Scale = (/0.25/)

  ;   ; opt@addRightString = "P2 "
  ;   opt@gsnDraw = False
  ;   opt@gsnFrame = False
  ;   opt@lbLabelBarOn = False
  ;   opt@vpHeightF = 0.6
  ;   opt@vpWidthF = 0.7
  ;   opt@detrend = False
  ;   opt@cnLineThicknessF = 12
  ;   opt@gsnLeftStringFontHeightF = 0.06
  ;   opt@gsnRightStringFontHeightF = 0.04
  ;   opt@tmLabelFontHeightF = 0.04
  ;   opt@tmXBLabelsOn = True 
  ;   opt@tmYLLabelsOn = True 
  ;   opt@tmXBOn = True 
  ;   opt@tmYLTickSpacingF = 15
  ;   opt@tmXBTickSpacingF = 20
  ;   opt@tmXBLabelStride = 1
  ;   opt@tmYLLabelStride = 1
  ;   opt@tmBorderThicknessF = 6
  ;   opt@clim = False

  ;   opt@cnLinesOn = False
  ;   ; opt@gsnLeftString = "SST"
  ;   opt@gsnRightStringOrthogonalPosF = -0.13
  ;   opt@gsnRightStringParallelPosF = 0.45
  ;   opt@gsnRightStringFontColor = "firebrick"
  ;   ; opt@gsnRightStringParallelPosF = 0.25
  ;   ; opt@dotslon = (/-26,-26,-12,-12,-26/)
  ;   ; opt@dotslat = (/60,70,70,60,60/)
  ;   opt@dots = True
  ;   opt@dotsLineThicknessF = 8
  ;   opt@dotslon = (/-26,-26,-0,-0,-26/)
  ;   opt@dotslat = (/56,68,68,56,56/)
  ;   ; range = (/54,64,-20,0/)
  ;   ; opt@dotslon = (/-18,-18,0,0,-18/)
  ;   ; opt@dotslat = (/54,64,64,54,54/)

  ;   opt@gsLineThicknessF = 10
  ;   opt@addRightString = ""
  ;   opt@addLeftString = "a "
  ;   opt@gsnLeftString = ""
  ;   opt@gsnStringBold = True
  ;   opt@gsnLeftStringParallelPosF = -0.3
  ;   opt@tiYAxisOffsetXF = 0.015
  ;   opt@tiYAxisFontHeightF = 0.035
  ;   opt@tiXAxisString = "Longitude"
  ;   opt@tiXAxisFontHeightF = 0.035
  ;   opt@tiXAxisOffsetYF = -0.03
  ;   opt@cnFillColors = (/"#6CB650","#9BCE7F","#C1E0B8","#FFFFFF","#F6E9BC","#F1CD5C","#F0B525","#A57E1E"/)
  ;   t = t_value(dimsizes(EAJII1)-2)
  ;   opt@cnLevels := (/-t@r99,-t@r95,-t@r90,t@r90,t@r95,t@r99,t@r999/)
  ;   ; opt@tiYAxisOffsetXF = -0.1
  ;   ; opt@gsnRightString = ""
  ;   ; delete(opt@gsnRightString)
  ;   item = (/"a","b","c","d","e","f","g","h"/)
  ; do i = 0, dimsizes(sources)-2
  ;   type@source = sources(i+1)
  ;   type@months := (/3/)
  ;   opt@addLeftString = item(i)
  ;   opt@tiYAxisString = "Latitude"
  ;   opt@tmYLOn = True
  ;   plot(i,0) = reg(wks,EAJII1,type,ranges,opt)
  ;   type@months := (/4, 5, 6/)
  ;   opt@tmYLOn = False
  ;   opt@tmYLLabelsOn = True
  ;   opt@gsnLeftString = ""
  ;   opt@addLeftString = ""
  ;   delete(opt@tiYAxisString)
  ;   ; plot(3) = reg(wks,EAJII1,type,ranges,opt)
  ;   ; type@months := (/5,6/)
  ;   ; opt@gsnRightStringParallelPosF = 0.17
  ;   plot(i,1) = reg(wks,EAJII1,type,ranges,opt)
  ;   type@months := (/7,8/)
  ;   opt@tmYLOn = False
  ;   opt@tmXBOn = True
  ;   opt@lbLabelBarOn = False  
  ;   opt@pmLabelBarOrthogonalPosF = 0.05
  ;   opt@pmLabelBarParallelPosF = .5
  ;   opt@pmLabelBarHeightF = 0.7
  ;   opt@pmLabelBarWidthF = 0.2
  ;   opt@lbLabelFontHeightF = 0.04
  ;   ; opt@gsnRightStringOrthogonalPosF = -0.65
  ;   ; opt@tiXAxisOffsetYF = -0.005
  ;   ; opt@gsnRightStringOrthogonalPosF = -0.35
  ;   ; opt@dotslon = (/-18,-18,0,0,-18/)
  ;   ; opt@dotslat = (/54,64,64,54,54/)
  ;   ; opt@dotslon = (/-28,-28,-0,-0,-28/)
  ;   ; opt@dotslat = (/54,68,68,54,54/)
  ;   opt@dotscolor = "forest green"
  ;   plot(i,2) = reg(wks,EAJII1,type,ranges,opt)
  ; end do
  ; resp = True
  ;   resp@gsnPanelXF = (/0.1,0.297,0.494,0.1,0.297,0.494,0.1,0.297,0.494,0.1,0.297,0.494/)
  ;   resp@gsnPanelYF = (/0.975,0.975,0.975,0.725,0.725,0.725,0.475,0.475,0.475,0.225,0.225,0.225/)
  ;   resp@gsnPanelBottom = 0.1
  ; gsn_panel(wks,ndtooned(plot(:3,:)),(/4,3/),resp)
  ; gsn_panel(wks,ndtooned(plot(4:,:)),(/4,3/),resp)
; FIG S14 SVD
  ; type = 0
  ; type@months = (/7,8/)
  ; type@year  := year1
  ; range = (/30,80,-50,14/)
  ; SST = predata(type,range,opt)
  ; md_print(SST,True)
  ; type = 5
  ; type@level = 200
  ; type@source = "jra55"
  ; range = (/10,80,0,140/)
  ; H200 = predata(type,range,opt)
  ; md_print(H200,False)

  ; svd_ts = SVD(SST,H200,opt)
  ; printVarSummary(svd_ts)
  ; output_buffer(svd_ts)

  ; svd_ts = input_buffer(True)
  ; ; printVarSummary(ts)

  ; wks = gsn_open_wks(fig,readpath(1)+folder+"/EAJII fig S14")
  ; plot = new(3,"graphic")
  ; opt@gsnDraw = False
  ; opt@gsnFrame = False
  ; type = 5
  ;   type@level = 200
  ;   type@months = (/7,8/)
  ;   type@source = "jra55"
  ; range = (/10,80,0,160/)
  ; setNatureMode(opt)
  ; opt@tiYAxisOffsetXF = 0.02
  ; opt@tiXAxisOffsetYF = -0.04
  ; opt@tmBorderThicknessF = 7
  ; opt@cnLineThicknessF = 7
  ; opt@tiXAxisOffsetYF = 0.005
  ; opt@tiXAxisString = "Longitude"
  ; opt@tiYAxisString = "Latitude"
  ; opt@gsnLeftStringParallelPosF = -0.19

  ; opt@addLeftString = "b"
  ; opt@gsnLeftString = ""
  ; opt@gsnStringBold = True
  ; opt@gsnRightString = ""
  ; opt@vpHeightF = 0.6
  ; opt@vpWidthF = 1.0
  ; opt@Scale := 5
  ; opt@lbLabelBarOn = True
  ; opt@lbOrientation = "Vertical"
  ; opt@pmLabelBarWidthF = 0.2
  ; opt@lbTitleString = "Correlation"
  ; opt@pmLabelBarOrthogonalPosF = 0.1
  ; opt@lbTitleOffsetF = 0.2
  ; opt@debug = True
  ; plot(1) = reg(wks,svd_ts(0,:),type,range,opt)
  ; type = 0
  ;   type@source = "combined"
  ; range = (/10,80,-70,20/)
  ; opt@addLeftString = "a"
  ; opt@tiXAxisOffsetYF = -0.035
  ; opt@vpHeightF = 0.6
  ; opt@vpWidthF = 0.7
  ; opt@gsnLeftStringParallelPosF = -0.27
  ; opt@Scale := 0.2
  ; opt@lbLabelBarOn = False
  ; opt@debug = False

  ; plot(0) = reg(wks,svd_ts(1,:),type,range,opt)

  ; opt@addLeftString = "c"
  ; opt@tiXAxisString = "Time (years)"
  ; opt@tiYAxisString = "Std. dev"
  ; opt@tiXAxisOffsetYF = -0.01
  ; opt@vpWidthF = 1.99
  ; opt@gsnLeftStringParallelPosF = -0.09
  ; opt@gsnXYBarChart = False
  ; opt@tmXBTickSpacingF = 3
  ; R = escorc(svd_ts(0,:),svd_ts(1,:))
  ; opt@name = "R = "+sprintf("%.2f",R)
  ; opt@LegendPos = (/2016,2/)
  ; opt@txFontHeightF = 0.045
  ; opt@xyLineThicknesses = (/10.,10/)

  ; plot(2) = plot_ts(wks,svd_ts,opt)
  ; res_text = True
  ;   res_text@txFontColor = "tomato"
  ;   res_text@txJust = "CenterLeft"
  ; ploto = gsn_add_text(wks,plot(2),"SST",1998.6,2.1,res_text)  
  ;   res_text@txFontColor = "forest green"
  ; ploto = gsn_add_text(wks,plot(2),"H200",1998.6,1.0,res_text)




  ; resp = True
  ;   resp@gsnPanelLabelBar = False
  ;   resp@lbOrientation = "Vertical"
  ;   resp@pmLabelBarParallelPosF = 0.33
  ;   resp@pmLabelBarOrthogonalPosF = 0.01
  ;   setLabelbar(resp)
  ;   resp@lbBoxLineThicknessF = 10
  ;   resp@lbLabelFontHeightF = 0.01
  ;   setLabelbarTitle(resp)
  ;   resp@lbTitleOffsetF = 0.6
  ;   resp@lbTitleString = "Correlation"
  ;   resp@pmLabelBarHeightF = 0.3
  ;   resp@pmLabelBarWidthF = 0.1
  ;   resp@gsnPanelScalePlotIndex = 0
  ;   resp@gsnPanelRowSpec = True
  ;   resp@gsnPanelXF = (/0.1,0.48,0.1/)
  ;   resp@gsnPanelYF = (/0.95,0.95,0.6/)
  ;   resp@gsnPanelXWhiteSpacePercent = 20
  ; gsn_panel(wks,plot,(/2,1/),resp)

; FIG S15
  ; type = 5
  ;   type@level = 200
  ;   type@source = "jra55"
  ;   type@months := 1
  ;   type@year := year1
  ; range = (/10,90,-80,60/)
  ; wks = gsn_open_wks(fig,readpath(1)+folder+"/EAJII fig S15")
  ; plot = new(6,"graphic")


  ; opt = True
  ;   opt@lbLabelBarOn = False
  ;   opt@gsnDraw = False
  ;   opt@gsnFrame = False
  ;   opt@vpHeightF = 0.6
  ;   opt@vpWidthF = 0.8
  ;   opt@Scale = 15
  ;   opt@tmXBTickSpacingF = 15
  ;   opt@tiYAxisString = "Latitude"
  ;   opt@tiXAxisString = "Longitude"
  ;   opt@tiXAxisOffsetYF = -0.035
  ;   opt@gsnLeftStringParallelPosF = -0.25
  ;   setNatureMode(opt)
  ;   opt@gsnRightString = "Jan"
  ;   opt@gsnRightStringOrthogonalPosF = -0.9
  ;   opt@gsnRightStringParallelPosF = 0.7
  ;   opt@gsnRightStringFontColor = "tomato"
  ;   opt@gsnRightStringFontHeightF = 0.04
  ;   opt@addLeftString = "a"
  ;   type@months = 1
  ; plot(0) = reg(wks,EAJII1,type,range,opt)
  ;   opt@gsnRightString = "Feb"
  ;   opt@addLeftString = "b"
  ;   type@months = 2
  ; plot(2) = reg(wks,EAJII1,type,range,opt)
  ;   opt@gsnRightString = "Mar"
  ;   opt@addLeftString = "c"
  ;   type@months = 3
  ; plot(4) = reg(wks,EAJII1,type,range,opt)
  ;   opt@gsnRightString = "Jan"
  ;   opt@addLeftString = "d"
  ;   type@months = 1
  ; plot(1) = reg(wks,ILSST1,type,range,opt)
  ;   opt@gsnRightString = "Feb"  
  ;   opt@addLeftString = "e"
  ;   type@months = 2
  ; plot(3) = reg(wks,ILSST1,type,range,opt)
  ;   opt@gsnRightString = "Mar"
  ;   opt@addLeftString = "f"
  ;   type@months = 3
  ; plot(5) = reg(wks,ILSST1,type,range,opt)

  ; resp = True
  ;   resp@gsnPanelLabelBar = True
  ;   resp@lbOrientation = "Vertical"
  ;   ; resp@pmLabelBarParallelPosF = 0.33
  ;   resp@pmLabelBarOrthogonalPosF = 0.022
  ;   setLabelbar(resp)
  ;   resp@lbLabelFontHeightF = 0.013
  ;   setLabelbarTitle(resp)
  ;   resp@lbTitleString = "Correlation"
  ;   resp@pmLabelBarHeightF = 0.7
  ;   resp@pmLabelBarWidthF = 0.1
  ;   setLabelbarTitle(resp)
  ;   resp@gsnPanelXWhiteSpacePercent = 5.
  ;   resp@gsnPanelYWhiteSpacePercent = 10.
  ;   resp@gsnPanelBottom = 0.01
  ;   resp@gsnPanelRight = 0.99
  ; gsn_panel(wks,plot,(/3,2/),resp)
; FIG S16
  type = 14
  type@level = 850
  type@source = "jra55"
  type@year = year
  type@months = (/7,8/)
  range = (/0,60,100,160/)
  relv850 = predata(type,range,opt)
  relv850 = (/relv850*1e+6/)
  tem = EOF(relv850,range,opt)
  PJ = tem(0,:)
  PJ0 = dim_standardize_Wrap(PJ({year0}))
  PJ1 = dim_standardize_Wrap(PJ({year1}))

 ; plot = new(3,"graphic")
  ; wks = gsn_open_wks(fig,readpath(1)+folder+"/EAJII fig S5")
  ;   opt@vpHeightF = 0.55
  ;   opt@vpWidthF = 1.69
  ;   opt@gsnLeftString = "";"(b) EAJII & PC1"
  ;   opt@addLeftString = "c"
  ;   opt@gsnStringBold = True
  ;   opt@gsnLeftStringParallelPosF = -0.11
  ;   opt@gsnRightString = ""
  ;   opt@gsnDraw = False
  ;   opt@gsnFrame = False
  ;   opt@tmYLValues = ispan(-9,9,3)
  ;   opt@tmYROn = True
  ;   opt@dots = False
  ;   ; opt@tmYUseLeft
  ;   opt@minmax = (/-10,10/)
  ;   opt@tmYRValues = ispan(-3,3,1)*dim_stddev(EAJII)
  ;   opt@tmYRLabels = ispan(-3,3,1)
  ;   opt@tiYAxisString = "EAJII index (m s~S~-1~N~)"
  ;   opt@tiYAxisOffsetXF = 0.025
  ;   opt@tiXAxisString = "Time (years)"
  ;   opt@tiXAxisOffsetYF = -0.01

  ; plot(2) = plot_ts(wks,EAJII,opt)

  ; res_YR = True
  ; res_YR@txFontHeightF = 0.03
  ; plot_yr = add_YRAxisString(wks,plot(2),"Std. dev",res_YR)

  ; rline = True
  ;   rline@gsLineThicknessF = 12.
  ;   rline@gsLineDashPattern = 1
  ;   rline@gsLineColor = "dodgerblue1"
  ; line = gsn_add_polyline(wks, plot(2), (/1998.5,1998.5/), (/10,-10/), rline)
    
    
  ; ;EOF
  ;   opt@detrend = False
  ;   opt@data = 1
  ; type = 3
  ;   type@level = 200
  ;   ; type@year := ispan(1999,2018,1)
  ;   type@year := ispan(1979,1998,1)
  ;   ; type@year := ispan(1999,2018,1)
  ;   type@months := (/7,8/)
  ;   type@source = "ERA5"
  ;   ; range = (/20,55,80,130/)
  ; range = (/20,60,80,130/)
  ; X := predata(type,range,opt)
  ;   opt@isPlot = False
  ;   opt@neof = 2
  ;   opt@jopt = 0
  ;   opt@weight = True
  ;   opt@reof = False
  ;   opt@rev := (/-1, -1,1/)
  ;   opt@name = "EAJ"
  ;   opt@lbOrientation = "Vertical"
  ;   opt@xcnLevels = (/-4,-3,-2,-1,1,2,3,4/)
  ;   opt@minmax = (/-3,3/)
  ;   opt@vpHeightF = 0.6
  ; EAJ0 := EOF(X,range,opt)
  ;   EAJ0@units = ""
  ;   pcvar0 = EAJ0@pcvar

  ;   opt@rev = (/1, -1,1/)
  ;   type@year := ispan(1999,2018,1)
  ; X := predata(type,range,opt)
  ; EAJ1 = EOF(X,range,opt)
  ;   EAJ1@units = ""
  ;   pcvar1 = EAJ1@pcvar

  ;   ts0 := EAJ0(0,:)
  ;   ts1 := EAJ1(0,:)   
  ;   year0 := dimsizes(ts0&year)
  ;   year1 := dimsizes(ts1&year)
  ;   t0 = t_value(year0-2)
  ;   t1 = t_value(year1-2)
  ;   ;叠加PC1及相关系数
  ;   rts = True
  ;   rts@xyLineThicknessF = 15
  ;   ts = ts0
  ;   ts = (/ts0*dim_stddev(EAJII)/)
  ;   plot_o = add_ts(wks,plot(2),ts,rts)
  ;   ts := ts1
  ;   ts = (/ts1*dim_stddev(EAJII)/)
  ;   rts@xyLineColor = "forest green"
  ;   plot_o = add_ts(wks,plot(2),ts,rts)

  ;   name0 = "R1 = "+sprintf("%.2f",escorc(EAJII0,ts0))
  ;   name1 = "R2 = "+sprintf("%.2f",escorc(EAJII1,ts1))
  ;   pos0 = (/1985,-7/)
  ;   pos1 = (/2006,-7/)
  ;   res_text               = True                  ; text mods desired
  ;     res_text@txFontHeightF = 0.04               ; change text size
  ;     res_text@txJust        = "CenterLeft"          ; text justification
  ;     res_text@txFontColor   = "tomato"
  ;   plot_o = gsn_add_text(wks,plot(2),name0,pos0(0),pos0(1),res_text)
  ;     res_text@txFontColor   = "forest green"
  ;   plot_o = gsn_add_text(wks,plot(2),name1,pos1(0),pos1(1),res_text)
    
    
  ;   range=(/10,65,70,160/)
  ;   type = 3
  ;   type@level = 200
  ;   opt@data = 1
  ;   opt@clim = True
  ;   opt@climLineThicknessF = 15.
  ;   opt@lbLabelBarOn = False  
  ;   opt@vpWidthF = 0.7
  ;   opt@vpHeightF = 0.5
  ;   opt@Scale = 1.0
  ;   ; opt@gsnStringFontHeightF = 0.042
  ;   ; opt@tmLabelFontHeightF = 0.033
  ;   opt@tmYLTickSpacingF = 10
  ;   opt@tmXBTickSpacingF = 10
  ;   opt@tmXBLabelStride = 2
  ;   delete(opt@lbStyle)
  ;   ; opt@tmYLLabelFontHeightF = 0.03
  ;   opt@tmYLLabelStride = 1

  ;   opt@gsnLeftString = "";"EOF1 "+sprintf("%5.1f", pcvar0(0)) +"%"
  ;   opt@addLeftString = "a"
  ;   opt@gsnStringBold = True
  ;   opt@gsnLeftStringFontHeightF = 0.04
  ;   opt@gsnLeftStringParallelPosF = -0.26
  ;   opt@gsnLeftStringOrthogonalPosF = 0.05
  ;   opt@gsnRightString = ts0@units
  ;   opt@addRightString = "";"P1 "
  ;       ; rts@gsnRightString = sprintf("%5.1f", pcvar1(0)) +"%"
  ;   opt@tmYLLabelsOn = True
  ;   ; opt@tmXBLabelsOn = False
  ;   opt@tiYAxisString = "Latitude"
  ;   opt@tiYAxisOffsetXF = 0.024
  ;   opt@tiXAxisString = "Longitude"
  ;   opt@tiXAxisOffsetYF = -0.04
  ;   opt@dots = True
  ;   opt@dotsColor = "tomato"
  ;   opt@dotslat := (/38.75,43.75,43.75,38.75,38.75/)
  ;   opt@dotslon := (/90.,90,120,120,90/)
  ;   opt@dotsLineThicknessF = 10.
  ;   opt@cnLineThicknessF = 8.
  ;   plot(0) = reg(wks,ts0,type,range,opt)

  ;   opt@addLeftString = "b"

  ;   ; opt@gsnLeftStringParallelPosF = 0.
  ;   opt@addRightString = "";"P2 "
  ;   opt@tmXBLabelsOn = True
  ;   opt@tmYLLabelsOn = True 
  ;   opt@gsnLeftString = "";"EOF1 "+sprintf("%5.1f", pcvar1(0)) +"%"
  ;   opt@lbLabelBarOn = True
  ;   opt@pmLabelBarOrthogonalPosF = 0.02
  ;   opt@pmLabelBarParallelPosF = 0.48
  ;   opt@pmLabelBarHeightF = 0.52
  ;   opt@lbOrientation = "Vertical"
  ;   ; opt@tiYAxisString = ""
  ;   opt@tiXAxisOffsetYF = -0.03
  ;   opt@lbTitleString = "Correlation"
  ;   plot(1) = reg(wks,ts1,type,range,opt)

  ; resp = True
  ; resp@gsnPanelRight = 0.85
  ; resp@gsnPanelRowSpec = True
  ; resp@gsnPanelXF = (/0.1,0.55,0.1/)
  ; resp@gsnPanelYF = (/0.9,0.9,0.55/)
  ; gsn_panel(wks,plot,(/2,1/),resp)
end