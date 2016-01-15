unit dll_com_locationapi;

interface

type
  PSystemTime = ^TSystemTime;
  TSystemTime = record
    wYear: Word;
    wMonth: Word;
    wDayOfWeek: Word;
    wDay: Word;
    wHour: Word;
    wMinute: Word;
    wSecond: Word;
    wMilliseconds: Word;
  end;
  SYSTEMTIME = TSystemTime;
// interface ILocation

type
  {
    HKEY_CLASSES_ROOT\Interface\
  }
  REFPROPERTYKEY = PAnsiChar;
  PROPVARIANT = Pointer;
  
  ILocationReport = interface(IUnknown)
    ['{C8B7F7EE-75D0-4db9-B62D-7A0F369CA456}']
    function GetSensorID(var pSensorID: TGUID {SENSOR_ID}): HResult; stdcall;
    function GetTimestamp(var pCreationTime: SystemTime): HResult; stdcall;
    function GetValue(pKey: REFPROPERTYKEY;
      var pValue: PROPVARIANT): HResult; stdcall;
  end;

  ILatLongReport = interface(ILocationReport)
    ['{7FED806D-0EF8-4f07-80AC-36A0BEAE3134}']
    function GetAltitude(var pAltitude: double): HResult; stdcall;
    function GetAltitudeError(var pAltitudeError: double): HResult; stdcall;
    function GetErrorRadius(var pErrorRadius: double): HResult; stdcall;
    function GetLatitude(var pLatitude: double): HResult; stdcall;
    function GetLongitude(var pLongitude: double): HResult; stdcall;
  end;
  
  ILocationEvents = interface(IUnknown)
    ['{CAE02BBF-798B-4508-A207-35A7906DC73D}']
    function OnLocationChanged: HResult; stdcall;
    function OnStatusChanged: HResult; stdcall;
  end;

  PLOCATION_REPORT_STATUS = Pointer;
  PLOCATION_DESIRED_ACCURACY = Pointer;
  
  ILocation = interface(IUnknown)
    ['{AB2ECE69-56D9-4F28-B525-DE1B0EE44237}']
    // {AB2ECE69-56D9-4F28-B525-DE1B0EE44237}
    function GetDesiredAccuracy(reportType: TGUID; var pMilliseconds: PLOCATION_DESIRED_ACCURACY): HResult; stdcall;
    // reportType: IID_ILatLongReport
    function GetReport(reportType: TGUID; var ppLocationReport: ILocationReport): HResult; stdcall;
    function GetReportInterval(reportType: TGUID; var pMilliseconds: Longword): HResult; stdcall;
    function GetReportStatus(reportType: TGUID; var pStatus: PLOCATION_REPORT_STATUS): HResult; stdcall;
    function RegisterForReport(pEvents: ILocationEvents; reportType: TGUID; dwRequestedReportInterval: Longword): HResult; stdcall;
    function RequestPermissions(hParent: Longword {HWND}; reportType: TGUID; count: Longword; fModal: LongBOOL): HResult; stdcall;
    function SetDesiredAccuracy(reportType: TGUID; desiredAccuracy: PLOCATION_DESIRED_ACCURACY): HResult; stdcall;
    function SetReportInterval(reportType: TGUID; millisecondsRequested: Longword): HResult; stdcall;
    function UnregisterForReport(reportType: TGUID): HResult; stdcall;
  end;

  IDefaultLocation = interface(IUnknown)
    ['{A65AF77E-969A-4a2e-8ACA-33BB7CBB1235}']
    function GetReport(reportType: TGUID; var ppLocationReport: ILocationReport): HRESULT; stdcall;
    function SetReport(reportType: TGUID; ppLocationReport: ILocationReport): HResult; stdcall;
  end;

  ICivicAddressReport = interface(IUnknown)
    ['{C0B19F70-4ADF-445d-87F2-CAD8FD711792}']
    function GetAddressLine1(pbstrAddress1: PWideChar): HResult; stdcall;
    function GetAddressLine2(pbstrAddress2: PWideChar): HResult; stdcall;
    function GetCity(pbstrCity: PWideChar): HResult; stdcall;
    function GetCountryRegion(pbstrCountryRegion: PWideChar): HResult; stdcall;
    function GetDetailLevel(pDetailLevel: PWideChar): HResult; stdcall;
    function GetPostalCode(pbstrPostalCode: PWideChar): HResult; stdcall;
    function GetStateProvince(pbstrStateProvince: PWideChar): HResult; stdcall;
  end;
  
implementation

end.
