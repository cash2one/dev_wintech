(*
          1    0 00013D35 CMP_GetBlockedDriverInfo
          2    1 00013E6D CMP_GetServerSideDeviceInstallFlags
          3    2 00013BF2 CMP_Init_Detection
          4    3 000074B9 CMP_RegisterNotification
          5    4 00013BD5 CMP_Report_LogOn
          6    5 0000560C CMP_UnregisterNotification
          7    6 0000A495 CMP_WaitNoPendingInstallEvents
          8    7 00013C13 CMP_WaitServicesAvailable
          9    8 0000B4DF CM_Add_Driver_PackageW
         10    9 0000B512 CM_Add_Driver_Package_ExW
         11    A 000133C5 CM_Add_Empty_Log_Conf
         12    B 00012AF9 CM_Add_Empty_Log_Conf_Ex
         13    C 00011CED CM_Add_IDA
         14    D 00011C49 CM_Add_IDW
         15    E 00011CA6 CM_Add_ID_ExA
         16    F 000117E5 CM_Add_ID_ExW
         17   10 000160F3 CM_Add_Range
         18   11 0001A43D CM_Add_Res_Des
         19   12 00019905 CM_Add_Res_Des_Ex
         20   13 000121DC CM_Apply_PowerScheme
         21   14 00014341 CM_Connect_MachineA
         22   15 0001402A CM_Connect_MachineW
         23   16 00011EC6 CM_Create_DevNodeA
         24   17 00011D0B CM_Create_DevNodeW
         25   18 00011D2C CM_Create_DevNode_ExA
         26   19 0000B2A7 CM_Create_DevNode_ExW
         27   1A 000151CA CM_Create_Range_List
         28   1B 000172CB CM_Delete_Class_Key
         29   1C 00016DE9 CM_Delete_Class_Key_Ex
         30   1D 0001724D CM_Delete_DevNode_Key
         31   1E 000167F1 CM_Delete_DevNode_Key_Ex
         32   1F 00018E7C CM_Delete_Device_Interface_KeyA
         33   20 00018BD0 CM_Delete_Device_Interface_KeyW
         34   21 00018E0F CM_Delete_Device_Interface_Key_ExA
         35   22 000189A1 CM_Delete_Device_Interface_Key_ExW
         36   23 000121B5 CM_Delete_Driver_PackageW
         37   24 00011F55 CM_Delete_Driver_Package_ExW
         38   25 000121F0 CM_Delete_PowerScheme
         39   26 000161F5 CM_Delete_Range
         40   27 00019091 CM_Detect_Resource_Conflict
         41   28 00018E97 CM_Detect_Resource_Conflict_Ex
         42   29 00011B9B CM_Disable_DevNode
         43   2A 00010A54 CM_Disable_DevNode_Ex
         44   2B 000134F1 CM_Disconnect_Machine
         45   2C 00016451 CM_Dup_Range_List
         46   2D 00011B75 CM_Duplicate_PowerScheme
         47   2E 00011BB6 CM_Enable_DevNode
         48   2F 00010C4D CM_Enable_DevNode_Ex
         49   30 0001726B CM_Enumerate_Classes
         50   31 0000A38B CM_Enumerate_Classes_Ex
         51   32 0001AA54 CM_Enumerate_EnumeratorsA
         52   33 0001A845 CM_Enumerate_EnumeratorsW
         53   34 0001A8C3 CM_Enumerate_Enumerators_ExA
         54   35 0001A54B CM_Enumerate_Enumerators_ExW
         55   36 00015466 CM_Find_Range
         56   37 000156C1 CM_First_Range
         57   38 000133E6 CM_Free_Log_Conf
         58   39 00012D15 CM_Free_Log_Conf_Ex
         59   3A 0001312D CM_Free_Log_Conf_Handle
         60   3B 000157C9 CM_Free_Range_List
         61   3C 00019731 CM_Free_Res_Des
         62   3D 00019179 CM_Free_Res_Des_Ex
         63   3E 000196A5 CM_Free_Res_Des_Handle
         64   3F 00010542 CM_Free_Resource_Conflict_Handle
         65   40 000081D5 CM_Get_Child
         66   41 00008083 CM_Get_Child_Ex
         67   42 00017B50 CM_Get_Class_Key_NameA
         68   43 000172AA CM_Get_Class_Key_NameW
         69   44 00017406 CM_Get_Class_Key_Name_ExA
         70   45 00016D1D CM_Get_Class_Key_Name_ExW
         71   46 00017B2F CM_Get_Class_NameA
         72   47 00017289 CM_Get_Class_NameW
         73   48 00017391 CM_Get_Class_Name_ExA
         74   49 00016B5D CM_Get_Class_Name_ExW
         75   4A 0001517C CM_Get_Class_PropertyW
         76   4B 00006641 CM_Get_Class_Property_ExW
         77   4C 0001515B CM_Get_Class_Property_Keys
         78   4D 00014C2D CM_Get_Class_Property_Keys_Ex
         79   4E 00018C12 CM_Get_Class_Registry_PropertyA
         80   4F 00017F14 CM_Get_Class_Registry_PropertyW
         81   50 0001A8A5 CM_Get_Depth
         82   51 0001A685 CM_Get_Depth_Ex
         83   52 00017C1C CM_Get_DevNode_Custom_PropertyA
         84   53 00008710 CM_Get_DevNode_Custom_PropertyW
         85   54 00009DBD CM_Get_DevNode_Custom_Property_ExA
         86   55 00007D26 CM_Get_DevNode_Custom_Property_ExW
         87   56 0001509E CM_Get_DevNode_PropertyW
         88   57 00007770 CM_Get_DevNode_Property_ExW
         89   58 0001507D CM_Get_DevNode_Property_Keys
         90   59 0001464B CM_Get_DevNode_Property_Keys_Ex
         91   5A 00018B61 CM_Get_DevNode_Registry_PropertyA
         92   5B 00008643 CM_Get_DevNode_Registry_PropertyW
         93   5C 00017D03 CM_Get_DevNode_Registry_Property_ExA
         94   5D 00008737 CM_Get_DevNode_Registry_Property_ExW
         95   5E 00007498 CM_Get_DevNode_Status
         96   5F 00007351 CM_Get_DevNode_Status_Ex
         97   60 00009BD0 CM_Get_Device_IDA
         98   61 000086EF CM_Get_Device_IDW
         99   62 00009BF1 CM_Get_Device_ID_ExA
        100   63 000070E5 CM_Get_Device_ID_ExW
        101   64 0001AA75 CM_Get_Device_ID_ListA
        102   65 0001A866 CM_Get_Device_ID_ListW
        103   66 0001A944 CM_Get_Device_ID_List_ExA
        104   67 00008501 CM_Get_Device_ID_List_ExW
        105   68 0001AA96 CM_Get_Device_ID_List_SizeA
        106   69 0001A887 CM_Get_Device_ID_List_SizeW
        107   6A 0001A9F4 CM_Get_Device_ID_List_Size_ExA
        108   6B 00009ADD CM_Get_Device_ID_List_Size_ExW
        109   6C 0000AA4C CM_Get_Device_ID_Size
        110   6D 00007267 CM_Get_Device_ID_Size_Ex
        111   6E 00017B71 CM_Get_Device_Interface_AliasA
        112   6F 000172E6 CM_Get_Device_Interface_AliasW
        113   70 0001747A CM_Get_Device_Interface_Alias_ExA
        114   71 00007680 CM_Get_Device_Interface_Alias_ExW
        115   72 00017B95 CM_Get_Device_Interface_ListA
        116   73 0001730A CM_Get_Device_Interface_ListW
        117   74 00017564 CM_Get_Device_Interface_List_ExA
        118   75 00005480 CM_Get_Device_Interface_List_ExW
        119   76 00017BB9 CM_Get_Device_Interface_List_SizeA
        120   77 0001732E CM_Get_Device_Interface_List_SizeW
        121   78 00017612 CM_Get_Device_Interface_List_Size_ExA
        122   79 00005FF7 CM_Get_Device_Interface_List_Size_ExW
        123   7A 0001510D CM_Get_Device_Interface_PropertyW
        124   7B 000067CD CM_Get_Device_Interface_Property_ExW
        125   7C 000150EC CM_Get_Device_Interface_Property_KeysW
        126   7D 000148ED CM_Get_Device_Interface_Property_Keys_ExW
        127   7E 0000A270 CM_Get_First_Log_Conf
        128   7F 0000A116 CM_Get_First_Log_Conf_Ex
        129   80 00013FB2 CM_Get_Global_State
        130   81 000135B1 CM_Get_Global_State_Ex
        131   82 00012908 CM_Get_HW_Prof_FlagsA
        132   83 000128E7 CM_Get_HW_Prof_FlagsW
        133   84 000127A5 CM_Get_HW_Prof_Flags_ExA
        134   85 000125AB CM_Get_HW_Prof_Flags_ExW
        135   86 0001296B CM_Get_Hardware_Profile_InfoA
        136   87 00012572 CM_Get_Hardware_Profile_InfoW
        137   88 00012839 CM_Get_Hardware_Profile_Info_ExA
        138   89 00012315 CM_Get_Hardware_Profile_Info_ExW
        139   8A 0001341F CM_Get_Log_Conf_Priority
        140   8B 000131B9 CM_Get_Log_Conf_Priority_Ex
        141   8C 00013401 CM_Get_Next_Log_Conf
        142   8D 00012F0D CM_Get_Next_Log_Conf_Ex
        143   8E 0001974F CM_Get_Next_Res_Des
        144   8F 00019405 CM_Get_Next_Res_Des_Ex
        145   90 00008065 CM_Get_Parent
        146   91 00007ED0 CM_Get_Parent_Ex
        147   92 0001A464 CM_Get_Res_Des_Data
        148   93 00019C25 CM_Get_Res_Des_Data_Ex
        149   94 0001A485 CM_Get_Res_Des_Data_Size
        150   95 00019EA5 CM_Get_Res_Des_Data_Size_Ex
        151   96 000105D1 CM_Get_Resource_Conflict_Count
        152   97 000108C9 CM_Get_Resource_Conflict_DetailsA
        153   98 00010671 CM_Get_Resource_Conflict_DetailsW
        154   99 000093AD CM_Get_Sibling
        155   9A 00009215 CM_Get_Sibling_Ex
        156   9B 00013F8D CM_Get_Version
        157   9C 0001343D CM_Get_Version_Ex
        158   9D 00011B75 CM_Import_PowerScheme
        159   9E 00012989 CM_Install_DevNodeW
        160   9F 0000B709 CM_Install_DevNode_ExW
        161   A0 000158AD CM_Intersect_Range_List
        162   A1 00015AE9 CM_Invert_Range_List
        163   A2 0000A28E CM_Is_Dock_Station_Present
        164   A3 0000A2A6 CM_Is_Dock_Station_Present_Ex
        165   A4 00013F9A CM_Is_Version_Available
        166   A5 00006573 CM_Is_Version_Available_Ex
        167   A6 0001AB14 CM_Locate_DevNodeA
        168   A7 0000A783 CM_Locate_DevNodeW
        169   A8 0001AAB4 CM_Locate_DevNode_ExA
        170   A9 00006971 CM_Locate_DevNode_ExW
        171   AA 000055CF CM_MapCrToSpErr
        172   AB 00005560 CM_MapCrToWin32Err
        173   AC 00016559 CM_Merge_Range_List
        174   AD 0001A4A3 CM_Modify_Res_Des
        175   AE 0001A11D CM_Modify_Res_Des_Ex
        176   AF 00011B75 CM_Move_DevNode
        177   B0 00010A49 CM_Move_DevNode_Ex
        178   B1 00015C99 CM_Next_Range
        179   B2 00018BEB CM_Open_Class_KeyA
        180   B3 00017CDC CM_Open_Class_KeyW
        181   B4 00017EB8 CM_Open_Class_Key_ExA
        182   B5 0000833B CM_Open_Class_Key_ExW
        183   B6 00017CB5 CM_Open_DevNode_Key
        184   B7 00008A06 CM_Open_DevNode_Key_Ex
        185   B8 00018E58 CM_Open_Device_Interface_KeyA
        186   B9 00018BAC CM_Open_Device_Interface_KeyW
        187   BA 00018DBD CM_Open_Device_Interface_Key_ExA
        188   BB 000187A5 CM_Open_Device_Interface_Key_ExW
        189   BC 00011EE7 CM_Query_And_Remove_SubTreeA
        190   BD 00011C0A CM_Query_And_Remove_SubTreeW
        191   BE 00011D76 CM_Query_And_Remove_SubTree_ExA
        192   BF 000111BD CM_Query_And_Remove_SubTree_ExW
        193   C0 00013FCD CM_Query_Arbitrator_Free_Data
        194   C1 000137F5 CM_Query_Arbitrator_Free_Data_Ex
        195   C2 00013FF1 CM_Query_Arbitrator_Free_Size
        196   C3 000139ED CM_Query_Arbitrator_Free_Size_Ex
        197   C4 000121F0 CM_Query_Remove_SubTree
        198   C5 00011B75 CM_Query_Remove_SubTree_Ex
        199   C6 00010035 CM_Query_Resource_Conflict_List
        200   C7 00011BEF CM_Reenumerate_DevNode
        201   C8 00010FED CM_Reenumerate_DevNode_Ex
        202   C9 00011C67 CM_Register_Device_Driver
        203   CA 000119A5 CM_Register_Device_Driver_Ex
        204   CB 00017BDA CM_Register_Device_InterfaceA
        205   CC 0001734F CM_Register_Device_InterfaceW
        206   CD 000176C9 CM_Register_Device_Interface_ExA
        207   CE 00016F2D CM_Register_Device_Interface_ExW
        208   CF 000121F0 CM_Remove_SubTree
        209   D0 00011B75 CM_Remove_SubTree_Ex
        210   D1 00011F0B CM_Request_Device_EjectA
        211   D2 00011C82 CM_Request_Device_EjectW
        212   D3 00011E1E CM_Request_Device_Eject_ExA
        213   D4 000115E5 CM_Request_Device_Eject_ExW
        214   D5 00012565 CM_Request_Eject_PC
        215   D6 00012206 CM_Request_Eject_PC_Ex
        216   D7 000121FB CM_RestoreAll_DefaultPowerSchemes
        217   D8 000121F0 CM_Restore_DefaultPowerScheme
        218   D9 00014012 CM_Run_Detection
        219   DA 000136CD CM_Run_Detection_Ex
        220   DB 000121F0 CM_Set_ActiveScheme
        221   DC 000151A3 CM_Set_Class_PropertyW
        222   DD 00014E95 CM_Set_Class_Property_ExW
        223   DE 00018CE0 CM_Set_Class_Registry_PropertyA
        224   DF 00018371 CM_Set_Class_Registry_PropertyW
        225   E0 00011BD1 CM_Set_DevNode_Problem
        226   E1 00010E1D CM_Set_DevNode_Problem_Ex
        227   E2 000150C5 CM_Set_DevNode_PropertyW
        228   E3 00009871 CM_Set_DevNode_Property_ExW
        229   E4 00018B88 CM_Set_DevNode_Registry_PropertyA
        230   E5 00017C91 CM_Set_DevNode_Registry_PropertyW
        231   E6 00017DDB CM_Set_DevNode_Registry_Property_ExA
        232   E7 0000AFDF CM_Set_DevNode_Registry_Property_ExW
        233   E8 00015134 CM_Set_Device_Interface_PropertyW
        234   E9 00014AA5 CM_Set_Device_Interface_Property_ExW
        235   EA 00012590 CM_Set_HW_Prof
        236   EB 0001243D CM_Set_HW_Prof_Ex
        237   EC 0001294A CM_Set_HW_Prof_FlagsA
        238   ED 00012929 CM_Set_HW_Prof_FlagsW
        239   EE 000127EF CM_Set_HW_Prof_Flags_ExA
        240   EF 0000ABD0 CM_Set_HW_Prof_Flags_ExW
        241   F0 00011B80 CM_Setup_DevNode
        242   F1 0000AA6A CM_Setup_DevNode_Ex
        243   F2 00015D9D CM_Test_Range_Available
        244   F3 00011C2E CM_Uninstall_DevNode
        245   F4 000113BD CM_Uninstall_DevNode_Ex
        246   F5 00017C01 CM_Unregister_Device_InterfaceA
        247   F6 00017376 CM_Unregister_Device_InterfaceW
        248   F7 000177F9 CM_Unregister_Device_Interface_ExA
        249   F8 0001712D CM_Unregister_Device_Interface_ExW
        250   F9 000121E5 CM_Write_UserPowerKey
*)
unit dll_cfgmgr32;

interface

implementation

end.