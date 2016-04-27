unit app.scene;

interface

type
  PModelLogic     = ^TModelLogic;     
  TModelLogic     = record
  end;

  PModelData      = ^TModelData;      
  TModelData      = record
  end;
  
  TDataModelInstance  = record    
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
  $Login_Password    --      Password Input
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
