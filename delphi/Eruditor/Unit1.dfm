object FMain: TFMain
  Left = 229
  Top = 111
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1069#1088#1091#1076#1080#1090#1086#1088
  ClientHeight = 539
  ClientWidth = 302
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  ScreenSnap = True
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Tabs: TPageControl
    Left = 0
    Top = 0
    Width = 302
    Height = 539
    ActivePage = DictSheet
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 0
    TabStop = False
    object FilterSheet: TTabSheet
      Caption = #1060#1080#1083#1100#1090#1088
      object FilterRes: TListBox
        Left = 0
        Top = 58
        Width = 294
        Height = 450
        Align = alClient
        ItemHeight = 13
        TabOrder = 0
        OnKeyDown = FilterResKeyDown
        OnMouseDown = FilterResMouseDown
      end
      object CoolBar1: TCoolBar
        Left = 0
        Top = 0
        Width = 294
        Height = 58
        AutoSize = True
        Bands = <
          item
            Control = LetterPanel
            ImageIndex = -1
            MinHeight = 26
            Width = 290
          end
          item
            Control = WordPanel
            ImageIndex = -1
            MinHeight = 26
            Width = 290
          end>
        object LetterPanel: TPanel
          Left = 9
          Top = 0
          Width = 277
          Height = 26
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object ComboBox7: TComboBox
            Tag = 7
            Left = 240
            Top = 2
            Width = 35
            Height = 21
            AutoCloseUp = True
            BevelKind = bkFlat
            BiDiMode = bdLeftToRight
            CharCase = ecUpperCase
            Ctl3D = False
            DropDownCount = 20
            ItemHeight = 0
            MaxLength = 1
            ParentBiDiMode = False
            ParentCtl3D = False
            TabOrder = 6
            Text = '*'
            OnChange = ComboBox7Change
            OnKeyPress = FilterKeyPress
            Items.Strings = (
              '*'
              #1040
              #1041
              #1042
              #1043
              #1044
              #1045
              #1046
              #1047
              #1048
              #1049
              #1050
              #1051
              #1052
              #1053
              #1054
              #1055
              #1056
              #1057
              #1058
              #1059
              #1060
              #1061
              #1062
              #1063
              #1064
              #1065
              #1066
              #1067
              #1068
              #1069
              #1070
              #1071)
          end
          object ComboBox6: TComboBox
            Tag = 6
            Left = 200
            Top = 2
            Width = 35
            Height = 21
            AutoCloseUp = True
            BevelKind = bkFlat
            BiDiMode = bdLeftToRight
            CharCase = ecUpperCase
            Ctl3D = False
            DropDownCount = 20
            ItemHeight = 0
            MaxLength = 1
            ParentBiDiMode = False
            ParentCtl3D = False
            TabOrder = 5
            Text = '*'
            OnChange = ComboBox6Change
            OnKeyPress = FilterKeyPress
            Items.Strings = (
              '*'
              #1040
              #1041
              #1042
              #1043
              #1044
              #1045
              #1046
              #1047
              #1048
              #1049
              #1050
              #1051
              #1052
              #1053
              #1054
              #1055
              #1056
              #1057
              #1058
              #1059
              #1060
              #1061
              #1062
              #1063
              #1064
              #1065
              #1066
              #1067
              #1068
              #1069
              #1070
              #1071)
          end
          object ComboBox5: TComboBox
            Tag = 5
            Left = 160
            Top = 2
            Width = 35
            Height = 21
            AutoCloseUp = True
            BevelKind = bkFlat
            BiDiMode = bdLeftToRight
            CharCase = ecUpperCase
            Ctl3D = False
            DropDownCount = 20
            ItemHeight = 0
            MaxLength = 1
            ParentBiDiMode = False
            ParentCtl3D = False
            TabOrder = 4
            Text = '*'
            OnChange = ComboBox5Change
            OnKeyPress = FilterKeyPress
            Items.Strings = (
              '*'
              #1040
              #1041
              #1042
              #1043
              #1044
              #1045
              #1046
              #1047
              #1048
              #1049
              #1050
              #1051
              #1052
              #1053
              #1054
              #1055
              #1056
              #1057
              #1058
              #1059
              #1060
              #1061
              #1062
              #1063
              #1064
              #1065
              #1066
              #1067
              #1068
              #1069
              #1070
              #1071)
          end
          object ComboBox4: TComboBox
            Tag = 4
            Left = 120
            Top = 2
            Width = 35
            Height = 21
            AutoCloseUp = True
            BevelKind = bkFlat
            BiDiMode = bdLeftToRight
            CharCase = ecUpperCase
            Ctl3D = False
            DropDownCount = 20
            ItemHeight = 0
            MaxLength = 1
            ParentBiDiMode = False
            ParentCtl3D = False
            TabOrder = 3
            Text = '*'
            OnChange = ComboBox4Change
            OnKeyPress = FilterKeyPress
            Items.Strings = (
              '*'
              #1040
              #1041
              #1042
              #1043
              #1044
              #1045
              #1046
              #1047
              #1048
              #1049
              #1050
              #1051
              #1052
              #1053
              #1054
              #1055
              #1056
              #1057
              #1058
              #1059
              #1060
              #1061
              #1062
              #1063
              #1064
              #1065
              #1066
              #1067
              #1068
              #1069
              #1070
              #1071)
          end
          object ComboBox3: TComboBox
            Tag = 3
            Left = 80
            Top = 2
            Width = 35
            Height = 21
            AutoCloseUp = True
            BevelKind = bkFlat
            BiDiMode = bdLeftToRight
            CharCase = ecUpperCase
            Ctl3D = False
            DropDownCount = 20
            ItemHeight = 0
            MaxLength = 1
            ParentBiDiMode = False
            ParentCtl3D = False
            TabOrder = 2
            Text = '*'
            OnChange = ComboBox3Change
            OnKeyPress = FilterKeyPress
            Items.Strings = (
              '*'
              #1040
              #1041
              #1042
              #1043
              #1044
              #1045
              #1046
              #1047
              #1048
              #1049
              #1050
              #1051
              #1052
              #1053
              #1054
              #1055
              #1056
              #1057
              #1058
              #1059
              #1060
              #1061
              #1062
              #1063
              #1064
              #1065
              #1066
              #1067
              #1068
              #1069
              #1070
              #1071)
          end
          object ComboBox2: TComboBox
            Tag = 2
            Left = 40
            Top = 2
            Width = 35
            Height = 21
            AutoCloseUp = True
            BevelKind = bkFlat
            BiDiMode = bdLeftToRight
            CharCase = ecUpperCase
            Ctl3D = False
            DropDownCount = 20
            ItemHeight = 0
            MaxLength = 1
            ParentBiDiMode = False
            ParentCtl3D = False
            TabOrder = 1
            Text = '*'
            OnChange = ComboBox2Change
            OnKeyPress = FilterKeyPress
            Items.Strings = (
              '*'
              #1040
              #1041
              #1042
              #1043
              #1044
              #1045
              #1046
              #1047
              #1048
              #1049
              #1050
              #1051
              #1052
              #1053
              #1054
              #1055
              #1056
              #1057
              #1058
              #1059
              #1060
              #1061
              #1062
              #1063
              #1064
              #1065
              #1066
              #1067
              #1068
              #1069
              #1070
              #1071)
          end
          object ComboBox1: TComboBox
            Tag = 1
            Left = 0
            Top = 2
            Width = 35
            Height = 21
            AutoCloseUp = True
            BevelKind = bkFlat
            BiDiMode = bdLeftToRight
            CharCase = ecUpperCase
            Ctl3D = False
            DropDownCount = 20
            ItemHeight = 0
            MaxLength = 1
            ParentBiDiMode = False
            ParentCtl3D = False
            TabOrder = 0
            Text = '*'
            OnChange = ComboBox1Change
            OnKeyPress = FilterKeyPress
            Items.Strings = (
              '*'
              #1040
              #1041
              #1042
              #1043
              #1044
              #1045
              #1046
              #1047
              #1048
              #1049
              #1050
              #1051
              #1052
              #1053
              #1054
              #1055
              #1056
              #1057
              #1058
              #1059
              #1060
              #1061
              #1062
              #1063
              #1064
              #1065
              #1066
              #1067
              #1068
              #1069
              #1070
              #1071)
          end
        end
        object WordPanel: TPanel
          Left = 9
          Top = 28
          Width = 277
          Height = 26
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          object FilterFind: TButton
            Left = 224
            Top = 2
            Width = 49
            Height = 21
            Caption = #1055#1086#1080#1089#1082
            TabOrder = 3
            OnClick = FilterFindClick
          end
          object Postfix: TComboBox
            Left = 176
            Top = 2
            Width = 43
            Height = 21
            AutoCloseUp = True
            BevelKind = bkFlat
            BiDiMode = bdLeftToRight
            CharCase = ecUpperCase
            Ctl3D = False
            DropDownCount = 20
            ItemHeight = 0
            MaxLength = 1
            ParentBiDiMode = False
            ParentCtl3D = False
            TabOrder = 2
            Text = '15'
            OnChange = PostfixChange
            OnKeyPress = FilterKeyPress
            Items.Strings = (
              '0'
              '1'
              '2'
              '3'
              '4'
              '5'
              '6'
              '7'
              '8'
              '9'
              '10'
              '11'
              '12'
              '13'
              '14'
              '15')
          end
          object FilterEdit: TEdit
            Left = 48
            Top = 2
            Width = 123
            Height = 21
            TabOrder = 1
            OnKeyPress = FilterKeyPress
          end
          object Prefix: TComboBox
            Left = 0
            Top = 2
            Width = 43
            Height = 21
            AutoCloseUp = True
            BevelKind = bkFlat
            BiDiMode = bdLeftToRight
            CharCase = ecUpperCase
            Ctl3D = False
            DropDownCount = 20
            ItemHeight = 0
            MaxLength = 1
            ParentBiDiMode = False
            ParentCtl3D = False
            TabOrder = 0
            Text = '15'
            OnChange = PrefixChange
            OnKeyPress = FilterKeyPress
            Items.Strings = (
              '0'
              '1'
              '2'
              '3'
              '4'
              '5'
              '6'
              '7'
              '8'
              '9'
              '10'
              '11'
              '12'
              '13'
              '14'
              '15')
          end
        end
      end
    end
    object DictSheet: TTabSheet
      Caption = #1057#1083#1086#1074#1072#1088#1100
      ImageIndex = 1
      object Dictionary: TListBox
        Left = 0
        Top = 30
        Width = 294
        Height = 478
        Align = alClient
        ItemHeight = 13
        TabOrder = 0
        OnClick = DictionaryClick
        OnKeyDown = DictionaryKeyDown
        OnMouseDown = DictionaryMouseDown
      end
      object CoolBar2: TCoolBar
        Left = 0
        Top = 0
        Width = 294
        Height = 30
        AutoSize = True
        Bands = <
          item
            Control = Panel3
            ImageIndex = -1
            MinHeight = 26
            Width = 290
          end>
        object Panel3: TPanel
          Left = 9
          Top = 0
          Width = 277
          Height = 26
          BevelOuter = bvNone
          TabOrder = 0
          object DictAdd: TPngSpeedButton
            Left = 208
            Top = 2
            Width = 21
            Height = 21
            Flat = True
            OnClick = DictAddClick
            PngImage.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              610000020E4944415478DA8D93CD6B134118877F33B3DD7C215ABF6F1E3C980A
              8A1AF5224862044110B4D6D2AA97246DEDDF533D2B94A252D42AFE014D5312DB
              1EDCB069D328917A4D42BA665B53683EC637B369459BC30EBCBCC3CC3BCFBE3C
              33CBD0639C7B303BCF180F833174823939B93E7B3FF27F2DEB05080EBE9789C9
              E83F6BAF5E2E22FFF61E7307189A93898908B2A6057BA70DBDDF8742268BB5D7
              77DD0106863FC9F85818C97419D6760BDE9301947279ACCDDC7107383FF259C6
              123791CA54B0F9BB0DCF8900CAB975AC4EDF3E08708489303807EB06B8402C7E
              038B4B555875021CF7A36416A89A2BAFEABB4E7EC38283EF64E259542D4A65BC
              DB174DD22B9BB0C8C1E9338770FDAC0FDDD3FB637AC6000B3E24E3135118390B
              35BB01263835C055DEAAB7D0A6439A57C39180E65C29A7D068DFD7876F990201
              863EC8F8F82DA456AAA8FE7200A0A2A66468B524B826A051B1D6C7211498A91A
              E9D160AD16C1061ECDC9D85804CBDFEBA892F17A0368527BA7FA75D42A3B9042
              403FE6DF07F04E07B4DF961265A30318FE38CFB8085328794C05C7E8D36B481B
              35D80D06FDA81F55B3E808DE7B998EC59F3DAFF1422C29479F5CC517D356000F
              7550C91661BC08B97B0717E37F015B4DAE00256AD7787EC52D608100212CE5B7
              613719BC877D28657FE0EBD4659780C4821C791CC2F2C62EEC5D40D7052AE606
              012EB905A4482C77C48A3DB122498003BFF31FD44BC1D9A50FB5130000000049
              454E44AE426082}
          end
          object DictDel: TPngSpeedButton
            Left = 232
            Top = 2
            Width = 21
            Height = 21
            Flat = True
            OnClick = DictDelClick
            PngImage.Data = {
              89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
              61000002944944415478DA6D93CF4FDB3014C7EDA6F9D5A61028038A004185A6
              0981C8058AB4532476EF54B63315276EEC2F81FFA05CB703B04D1424902C412F
              8C8BD10E3D6C0734A050464A429B900685CCF69A8E497DD28B2DE77DBEB6DF7B
              86A065787979CD33CDB14AA994CF56AB26E8605BA9949ACA640ABEE79DBD2E16
              3FD035483FDF57560AC99999A5CAC101A895CBD8310C3D7B7D6D7680913A31A1
              DD964AE0C1B236DE94CB794877EE9F9D5DADECEF03AF560381EF83C6CD0D762C
              4B7F7B75C544368786D4D4DC1CEA49A735E3E888C550736C7B1D7ECBE5B62210
              663DC3F8FB8378F0F4046CC3C076BDAE03080183C7C735E3F090FD0FADDE686C
              C3CF0303AADCD787E2C9A416C22C888C0DCBC2DD9393A0F7391C04ECDEF78E83
              1B8EA3B31C6C0F0EAAB2AAA2784F8F16C2900A11EF9D9F07E6F1318369302402
              26855D57CF5D5E9AF079926289048A777569214C8383661304AECBE634B8118D
              E27B022F12B85D85D036A988A220459635FFEE0EF8960522643D1289008EE340
              9DE73111D0172F2EDA15FA5F80647B606A0AC54451AB2104B816C89CCC2D2260
              41A8BFEB244077EF9F9E468AAA6AB77B7B80236BD116DC1EA35160909EBB0D02
              FDFDF9F9BF2BD0FBBF203B53F8F7EE2E8343803ADF1A43A16BDFC7D5C7472602
              43384EE09B62114448B2A22DD816454C817E8ED3789E6742D4E9DA2FD7C51724
              99B0B4B0B01553D56C756787C1E1911F2409DB82A007E434498E43C3242F8220
              00A125044983FDA8D7B721CA64D61C8C574398BA2BCBF881C061A93E8D8CA883
              8280D28AA249A2C84468657E5AD63ACBC19744A2C0379B4B14F6E271DC1445D6
              24CF2B4445866331F48A349B2C49E0DCB6375E9E9CE4DB55F8DADDBD46B61FF3
              24299FAB543A3EE78FA3A3EA98A214623C7F367D7ACA9EF31F5F4C3FCFA2F668
              0F0000000049454E44AE426082}
          end
          object DictEdit: TEdit
            Left = 0
            Top = 2
            Width = 201
            Height = 21
            TabOrder = 0
            OnChange = DictEditChange
            OnClick = DictEditClick
          end
        end
      end
    end
  end
end
