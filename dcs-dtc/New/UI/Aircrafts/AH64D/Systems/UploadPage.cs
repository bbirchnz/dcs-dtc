﻿using DTC.New.UI.Base.Systems;

namespace DTC.New.UI.Aircrafts.AH64D.Systems;

public partial class UploadPage : AircraftSystemPage
{
    public UploadPage(AH64DPage parent) : base(parent, nameof(parent.Configuration.Upload))
    {
        InitializeComponent();

        var upload = parent.Configuration.Upload;

        chkWaypoints.Checked = upload.Waypoints;
        chkWaypoints.CheckedChanged += (s, e) =>
        {
            upload.Waypoints = chkWaypoints.Checked;
            this.SavePreset();
        };

        chkControlMeasures.Checked = upload.ControlMeasures;
        chkControlMeasures.CheckedChanged += (s, e) =>
        {
            upload.ControlMeasures = chkControlMeasures.Checked;
            this.SavePreset();
        };

        chkTargets.Checked = upload.Targets;
        chkTargets.CheckedChanged += (s, e) =>
        {
            upload.Targets = chkTargets.Checked;
            this.SavePreset();
        };

        chkRoutes.Checked = upload.Routes;
        chkRoutes.CheckedChanged += (s, e) =>
        {
            upload.Routes = chkRoutes.Checked;
            this.SavePreset();
        };

        chkTSD.Checked = upload.TSD;
        chkTSD.CheckedChanged += (s, e) =>
        {
            upload.TSD = chkTSD.Checked;
            this.SavePreset();
        };
    }

    public override string GetPageTitle()
    {
        return "Upload Settings";
    }
}
