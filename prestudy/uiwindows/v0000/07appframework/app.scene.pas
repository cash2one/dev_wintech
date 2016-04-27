unit app.scene;

interface

type
  PModelData      = ^TModelData;      
  TModelData      = record
    ID            : integer;
  end;
                
  PModelData_DataBase = ^TModelData_DataBase;      
  TModelData_DataBase = record
  end;
  
  PModelData_AppScene = ^TModelData_AppScene;      
  TModelData_AppScene = record
  end;
  
  PModelData_UIScene  = ^TModelData_UIScene;      
  TModelData_UIScene  = record
  end;
          
  PModelLogic     = ^TModelLogic;     
  TModelLogic     = record
  end;

  TInstanceModelData  = record
    DataModel         : PModelData;
    DataModelID       : integer;
  end;
  
  PSceneSession   = ^TSceneSession;
  TSceneSession   = record
    Parent        : PSceneSession;
    FirstChild    : PSceneSession;
    LastChild     : PSceneSession;
    PrevSibling   : PSceneSession;
    NextSibling   : PSceneSession;

    //DataModel     : TModelData;
    //Logic         : TModelLogic;
    //DataInstance  : TDataInstance;
  end;
            
  PUISceneSession = ^TUISceneSession;
  TUISceneSession = record
    Base          : TSceneSession;
  end;

implementation

{*****************************************
  User Login Scene

  ModelData                  UIScene
  $Login_UserAccount --      User Account Input
  $Login_Password    --      Password Input -- on focus --> UIEdit Focus Scene
  $VerifyCode        --      Verify Code Input
                             LoginButton

  ModelLogic -- Login
    if IsEmpty($Login_UserAccount)
      Call --> Hint Message Scene 
    if IsEmpty($Login_Password)    
      Call --> Hint Message Scene 
    if IsEmpty($VerifyCode)
      Call --> Hint Message Scene

    Call RemoteAPI UserLoginService[
      $Login_UserAccount
      $Login_Password
      $VerifyCode
    ]

    //============================
    // input
    App Scene Manager [应用场景管理]
    CommandCenter Wait Command:
      Command_Login_Error
        Call Show Login Error Scene
      Command_Login_Success
        Call User Session Active Scene 
    //============================
    // output
*****************************************}
end.
