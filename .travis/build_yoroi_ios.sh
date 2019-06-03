#!/bin/bash

source $HOME/.cargo/env

cd ios
pod install --no-repo-update --verbose
cd -

if [ ! -f target.zip ]; then
    # delete target folder in react-native-cardano
    rm -rf node_modules/react-native-cardano/rust/target
    curl -O https://s3.amazonaws.com/yoroi-backups/target.zip
    unzip -a target.zip -d node_modules/react-native-cardano/rust/ 
fi

if [ ! -d "node_modules/react-native/third-party" ]; then
  cd node_modules/react-native ; ./scripts/ios-install-third-party.sh ; cd ../../
  cd node_modules/react-native/third-party/glog-0.3.5/ ; make distclean ; ./configure ; cd ../../../../
fi

# destination ids are at the botttom of this file
xcodebuild "-workspace" "ios/emurgo.xcworkspace" "-scheme" "emurgo" "-configuration" "Debug" "CODE_SIGN_IDENTITY=" "CODE_SIGNING_REQUIRED=NO" "PROVISIONING_PROFILE_SPECIFIER=" "PROVISIONING_PROFILE=" "DEVELOPMENT_TEAM=" "-destination" "id=FDF879EC-ABD1-46EF-B79C-98EC293AD6F3" "build" | xcpretty

ls -hl deploy

# { platform:iOS Simulator, id:0BC9DF2B-6196-4136-A2BD-F903C079E4AD, OS:10.3.1, name:iPad (5th generation) }
# { platform:iOS Simulator, id:6A3C6223-9A1E-4547-8410-9CA8C975E396, OS:11.0.1, name:iPad (5th generation) }
# { platform:iOS Simulator, id:DC3245D6-EFBA-4395-8FE7-714905D843B3, OS:11.1, name:iPad (5th generation) }
# { platform:iOS Simulator, id:17BDEA68-69F6-4EBC-B3E9-5BF8EF2DFA68, OS:11.2, name:iPad (5th generation) }
# { platform:iOS Simulator, id:F841F231-5794-4175-BBC2-C4231E85511C, OS:11.3, name:iPad (5th generation) }
# { platform:iOS Simulator, id:64D8C8DA-1258-4809-983B-2A4751455A5D, OS:11.4, name:iPad (5th generation) }
# { platform:iOS Simulator, id:FA012917-26B2-4884-A6C8-075135567F30, OS:12.0, name:iPad (5th generation) }
# { platform:iOS Simulator, id:7C607642-9C2D-4BD5-A61B-545D95A66B71, OS:12.1, name:iPad (5th generation) }
# { platform:iOS Simulator, id:A017B73A-5415-48EB-A56A-F19F9D22F7B7, OS:12.2, name:iPad (5th generation) }
# { platform:iOS Simulator, id:71EF4C0D-1087-49F4-89F2-001E6B27B6A7, OS:12.0, name:iPad (6th generation) }
# { platform:iOS Simulator, id:0951900B-6347-4443-B6D5-246439BFEB9D, OS:12.1, name:iPad (6th generation) }
# { platform:iOS Simulator, id:F0131CEC-912B-48CC-BD66-B24854DE6C24, OS:12.2, name:iPad (6th generation) }
# { platform:iOS Simulator, id:7ED46622-D399-42FD-BBD9-7E57B5E6BA80, OS:9.0, name:iPad 2 }
# { platform:iOS Simulator, id:2F6F7DEC-61F0-4DC1-B503-EA0C93F83BA5, OS:9.1, name:iPad 2 }
# { platform:iOS Simulator, id:1AD54960-D524-48C1-BDF4-C9D1B47F77C0, OS:9.2, name:iPad 2 }
# { platform:iOS Simulator, id:0CDE09ED-4E8D-430F-84F5-3E4F42B321F8, OS:9.3, name:iPad 2 }
# { platform:iOS Simulator, id:F6728AE6-93E1-493E-832B-01A87F0657A4, OS:9.0, name:iPad Air }
# { platform:iOS Simulator, id:0458C8FF-8E69-4EA3-825A-646515E8E966, OS:9.1, name:iPad Air }
# { platform:iOS Simulator, id:32D5EC44-4621-4FAE-8712-50FB057FA39F, OS:9.2, name:iPad Air }
# { platform:iOS Simulator, id:9CD69E22-9627-4AA1-A9D7-DC3CC8215240, OS:9.3, name:iPad Air }
# { platform:iOS Simulator, id:E2966051-C39E-4BA4-A596-18FE50CC62C0, OS:10.0, name:iPad Air }
# { platform:iOS Simulator, id:1A61D5AE-0CC0-42F2-8EED-AFBE47BFD723, OS:10.1, name:iPad Air }
# { platform:iOS Simulator, id:38747068-6973-4664-8943-A841DC0B6CB5, OS:10.2, name:iPad Air }
# { platform:iOS Simulator, id:886EDA59-3687-40C8-B398-FBCC39C038F5, OS:10.3.1, name:iPad Air }
# { platform:iOS Simulator, id:5097CC96-AE84-4CB3-9B3D-DF68212E1EDC, OS:11.0.1, name:iPad Air }
# { platform:iOS Simulator, id:E13048A1-4A05-4A7B-AF1F-A16C6D22E405, OS:11.1, name:iPad Air }
# { platform:iOS Simulator, id:A8D3D31F-1C80-4E71-8173-ADFDB345869F, OS:11.2, name:iPad Air }
# { platform:iOS Simulator, id:F14B5B85-4FD3-41FC-87B3-90CAB422887F, OS:11.3, name:iPad Air }
# { platform:iOS Simulator, id:90812A21-5769-4390-AD39-F4E498D474C1, OS:11.4, name:iPad Air }
# { platform:iOS Simulator, id:E9D9D697-C453-4D22-BD09-54683E28C12D, OS:12.0, name:iPad Air }
# { platform:iOS Simulator, id:ED95C908-FCC5-40BD-BCCF-EFA9B2D7882D, OS:12.1, name:iPad Air }
# { platform:iOS Simulator, id:C96985C1-CCDD-4D72-A9A8-1DF0F52A70B5, OS:12.2, name:iPad Air }
# { platform:iOS Simulator, id:BA2C9059-1294-45D5-A4D0-06D8650F6FAE, OS:12.2, name:iPad Air (3rd generation) }
# { platform:iOS Simulator, id:EEC56F6A-54EA-4833-939E-8845B79548B5, OS:9.0, name:iPad Air 2 }
# { platform:iOS Simulator, id:59A259CF-2CDB-4E1D-9AE4-E1C951D9F649, OS:9.1, name:iPad Air 2 }
# { platform:iOS Simulator, id:7A518BB3-3AE5-428D-BE93-6CC60115E3D9, OS:9.2, name:iPad Air 2 }
# { platform:iOS Simulator, id:F5D30F7D-2B2E-479C-B5FA-AD8592F551C9, OS:9.3, name:iPad Air 2 }
# { platform:iOS Simulator, id:72F66809-A29D-41E2-847E-233824464F4D, OS:10.0, name:iPad Air 2 }
# { platform:iOS Simulator, id:7455E659-CA1E-4B32-8060-27731ADA5340, OS:10.1, name:iPad Air 2 }
# { platform:iOS Simulator, id:A4F7D436-D819-4BD7-826A-680171841DFF, OS:10.2, name:iPad Air 2 }
# { platform:iOS Simulator, id:7C07DDB4-4CA0-4F5C-A9CB-4C6F63F53549, OS:10.3.1, name:iPad Air 2 }
# { platform:iOS Simulator, id:60DCA392-86B1-47D2-A81E-D395AB32AFA5, OS:11.0.1, name:iPad Air 2 }
# { platform:iOS Simulator, id:F0E8AEA5-C82B-4479-BAF4-D13BEBCDB3BC, OS:11.1, name:iPad Air 2 }
# { platform:iOS Simulator, id:3B4C642B-BD15-41BF-AFD2-735A4E26EA43, OS:11.2, name:iPad Air 2 }
# { platform:iOS Simulator, id:5844D4AE-C877-4F03-B03D-3A35DB988B4F, OS:11.3, name:iPad Air 2 }
# { platform:iOS Simulator, id:7C202ED0-9E0A-497D-AE9C-96F27F42F75B, OS:11.4, name:iPad Air 2 }
# { platform:iOS Simulator, id:D9DEDA93-CF1B-4E5A-9C03-4990F503F96A, OS:12.0, name:iPad Air 2 }
# { platform:iOS Simulator, id:06046439-FF5E-44A0-BB8D-3531086AA7A9, OS:12.1, name:iPad Air 2 }
# { platform:iOS Simulator, id:BA03C357-8B7E-4781-9A03-8176BAEF0058, OS:12.2, name:iPad Air 2 }
# { platform:iOS Simulator, id:760EC67B-CE15-4370-A692-E072ABAC436F, OS:9.1, name:iPad Pro }
# { platform:iOS Simulator, id:C06E1455-72CA-4BA4-A59C-73233EBE6BB5, OS:9.2, name:iPad Pro }
# { platform:iOS Simulator, id:BB75B74B-E495-4CF0-8D8C-2A56D94E0C52, OS:9.3, name:iPad Pro }
# { platform:iOS Simulator, id:9960293B-2359-42F9-A4B9-A9D75F2545FD, OS:10.0, name:iPad Pro (9.7 inch) }
# { platform:iOS Simulator, id:B93108B4-BD74-403E-8EB1-D2127AB94025, OS:10.1, name:iPad Pro (9.7 inch) }
# { platform:iOS Simulator, id:05514CBE-6489-473B-B551-476FEE1C3F0F, OS:10.2, name:iPad Pro (9.7 inch) }
# { platform:iOS Simulator, id:A1628FF3-7A3C-42E9-A9D3-E65E2345507C, OS:10.3.1, name:iPad Pro (9.7 inch) }
# { platform:iOS Simulator, id:9FEE8F54-E259-4D94-B062-C5B0818344C7, OS:11.0.1, name:iPad Pro (9.7-inch) }
# { platform:iOS Simulator, id:5E2B2B32-E6A0-47F0-8A91-5361189165EE, OS:11.1, name:iPad Pro (9.7-inch) }
# { platform:iOS Simulator, id:F808668D-716B-4D3F-84A6-A89DEA5354D9, OS:11.2, name:iPad Pro (9.7-inch) }
# { platform:iOS Simulator, id:396CD1C4-008C-49AF-ADDA-2E5789B63FE3, OS:11.3, name:iPad Pro (9.7-inch) }
# { platform:iOS Simulator, id:10ED9017-F7E6-4B2E-A869-F70AD560A6E1, OS:11.4, name:iPad Pro (9.7-inch) }
# { platform:iOS Simulator, id:765534D9-7E5F-4C95-8C6E-41CFD8160157, OS:12.0, name:iPad Pro (9.7-inch) }
# { platform:iOS Simulator, id:08392EC8-F846-4032-9DE8-A927E276D848, OS:12.1, name:iPad Pro (9.7-inch) }
# { platform:iOS Simulator, id:4051527D-993B-409A-97AD-311567F45C05, OS:12.2, name:iPad Pro (9.7-inch) }
# { platform:iOS Simulator, id:98F7CB16-0F59-4BD9-8361-68F25F9663F8, OS:10.3.1, name:iPad Pro (10.5-inch) }
# { platform:iOS Simulator, id:6DF4F4B5-EB97-44FC-B9B0-F4DDCAF5B5A9, OS:11.0.1, name:iPad Pro (10.5-inch) }
# { platform:iOS Simulator, id:7407064C-C02D-4DC5-916E-6251659FE683, OS:11.1, name:iPad Pro (10.5-inch) }
# { platform:iOS Simulator, id:6093A338-33F3-42B3-8B1B-0AF32F68CDC1, OS:11.2, name:iPad Pro (10.5-inch) }
# { platform:iOS Simulator, id:FED4FB04-06DA-413E-BE65-402A9ADA4850, OS:11.3, name:iPad Pro (10.5-inch) }
# { platform:iOS Simulator, id:425AE0CA-CC0D-4890-8CAF-7267FA866918, OS:11.4, name:iPad Pro (10.5-inch) }
# { platform:iOS Simulator, id:2057EBBB-553F-4CCA-BED0-3323E2E642CE, OS:12.0, name:iPad Pro (10.5-inch) }
# { platform:iOS Simulator, id:E4BE6C7C-3CCE-4AD0-98F2-8E05DFC40CA1, OS:12.1, name:iPad Pro (10.5-inch) }
# { platform:iOS Simulator, id:E44C62C6-BFF2-4313-94FF-4E2A16E64039, OS:12.2, name:iPad Pro (10.5-inch) }
# { platform:iOS Simulator, id:C91CCEC9-A7A4-45F1-9253-76968E3A39FE, OS:12.1, name:iPad Pro (11-inch) }
# { platform:iOS Simulator, id:53F443E7-D541-444D-9D52-8644C624D304, OS:12.2, name:iPad Pro (11-inch) }
# { platform:iOS Simulator, id:5CB0E40E-1A65-438B-96FC-AF1662AF679D, OS:10.0, name:iPad Pro (12.9 inch) }
# { platform:iOS Simulator, id:C2739744-CA5B-47AF-8F53-3D348DA944E0, OS:10.1, name:iPad Pro (12.9 inch) }
# { platform:iOS Simulator, id:E87B0427-57B3-46D4-B8B3-1E63E429AD23, OS:10.2, name:iPad Pro (12.9 inch) }
# { platform:iOS Simulator, id:6FF742C3-8713-4024-893C-8DF4A3E903EC, OS:10.3.1, name:iPad Pro (12.9 inch) }
# { platform:iOS Simulator, id:D1333745-9B3B-49BA-8581-9B5D3CB62F1E, OS:11.0.1, name:iPad Pro (12.9-inch) }
# { platform:iOS Simulator, id:32A1135D-75C1-48B3-AF5D-4C6E11308DD0, OS:11.1, name:iPad Pro (12.9-inch) }
# { platform:iOS Simulator, id:2BD93001-C123-4DEA-B4C8-E5C16C3019D9, OS:11.2, name:iPad Pro (12.9-inch) }
# { platform:iOS Simulator, id:62BA3E49-D9F8-4DF7-A64C-2826CDD19C78, OS:11.3, name:iPad Pro (12.9-inch) }
# { platform:iOS Simulator, id:9393FF4D-1373-42BD-B4F6-CACD05BC29C3, OS:11.4, name:iPad Pro (12.9-inch) }
# { platform:iOS Simulator, id:42512251-4CD6-44A5-8AD0-08E0486DB8B2, OS:12.0, name:iPad Pro (12.9-inch) }
# { platform:iOS Simulator, id:B6C9A842-CCCF-46E1-87FE-F16F8C9D6457, OS:12.1, name:iPad Pro (12.9-inch) }
# { platform:iOS Simulator, id:ECAA056F-C658-44AB-9828-6A9AF51A5A06, OS:12.2, name:iPad Pro (12.9-inch) }
# { platform:iOS Simulator, id:84D889A5-4E36-4B5B-AACC-BEAEA9E1F71D, OS:10.3.1, name:iPad Pro (12.9-inch) (2nd generation) }
# { platform:iOS Simulator, id:001B93E7-353F-49D1-8D07-205B6AA6A006, OS:11.0.1, name:iPad Pro (12.9-inch) (2nd generation) }
# { platform:iOS Simulator, id:E7F98608-D445-484B-A6DA-0C7D9FE3D798, OS:11.1, name:iPad Pro (12.9-inch) (2nd generation) }
# { platform:iOS Simulator, id:CBE82972-628A-4FC8-BCAF-04DC1CF0AC8D, OS:11.2, name:iPad Pro (12.9-inch) (2nd generation) }
# { platform:iOS Simulator, id:4A122708-07D4-4191-9C98-4541C676A624, OS:11.3, name:iPad Pro (12.9-inch) (2nd generation) }
# { platform:iOS Simulator, id:078932DA-DBBC-46EE-A3B8-123A03EE270F, OS:11.4, name:iPad Pro (12.9-inch) (2nd generation) }
# { platform:iOS Simulator, id:2C89A903-1A24-4353-A3F5-06ECC11C7EB6, OS:12.0, name:iPad Pro (12.9-inch) (2nd generation) }
# { platform:iOS Simulator, id:C156F02A-57EC-435D-8E25-677729784062, OS:12.1, name:iPad Pro (12.9-inch) (2nd generation) }
# { platform:iOS Simulator, id:201B3CC0-6DB5-4C8B-988E-38BD4EEABFDC, OS:12.2, name:iPad Pro (12.9-inch) (2nd generation) }
# { platform:iOS Simulator, id:2F69EA42-3E9C-49A8-81E2-0C62651BBDF3, OS:12.1, name:iPad Pro (12.9-inch) (3rd generation) }
# { platform:iOS Simulator, id:829B49CC-7BA9-4F0B-A986-597D3FDF4B85, OS:12.2, name:iPad Pro (12.9-inch) (3rd generation) }
# { platform:iOS Simulator, id:647C6BF5-47D5-43EE-96D7-C64CCE78C4C7, OS:9.0, name:iPad Retina }
# { platform:iOS Simulator, id:AC18E934-FAAE-40C2-AC7F-C7D5554A6E42, OS:9.1, name:iPad Retina }
# { platform:iOS Simulator, id:CFEFAA80-084B-492C-B65F-E9EA7539C546, OS:9.2, name:iPad Retina }
# { platform:iOS Simulator, id:B3F86B32-3F7C-4961-A688-771DF4343B77, OS:9.3, name:iPad Retina }
# { platform:iOS Simulator, id:5E0E64E1-F7C8-48DA-BB27-74BB4FC99D1F, OS:9.0, name:iPhone 4s }
# { platform:iOS Simulator, id:C68E0FA8-7467-4F9E-B13D-B795F7E1CD39, OS:9.1, name:iPhone 4s }
# { platform:iOS Simulator, id:27E4DC3C-80B2-4FFD-B32E-932061775B55, OS:9.2, name:iPhone 4s }
# { platform:iOS Simulator, id:0EAE6CBA-E465-4E06-9B46-A7BBEFDF4535, OS:9.3, name:iPhone 4s }
# { platform:iOS Simulator, id:D76763C9-6163-4F85-A4A2-AABC27E37771, OS:9.0, name:iPhone 5 }
# { platform:iOS Simulator, id:CC9C70FC-0F50-4387-932D-EAAD73EE36B3, OS:9.1, name:iPhone 5 }
# { platform:iOS Simulator, id:2AEDCD2A-0CF3-4E43-AEFF-4C7F64EBB2CB, OS:9.2, name:iPhone 5 }
# { platform:iOS Simulator, id:62B7E95C-3D63-47C5-8769-5F35EC5405DD, OS:9.3, name:iPhone 5 }
# { platform:iOS Simulator, id:4E363152-5DDC-4070-B732-5FF54244C727, OS:10.0, name:iPhone 5 }
# { platform:iOS Simulator, id:8D49105C-BF99-4E30-AAE8-D0D29DBF84D1, OS:10.1, name:iPhone 5 }
# { platform:iOS Simulator, id:FC47B6A9-EDDC-4DD1-85BD-6A717871F44A, OS:10.2, name:iPhone 5 }
# { platform:iOS Simulator, id:64346EC3-7A31-4694-B224-8FB9BA4C2599, OS:10.3.1, name:iPhone 5 }
# { platform:iOS Simulator, id:0ECD41CA-0F7E-4DBF-A7DE-85D9FB650445, OS:9.0, name:iPhone 5s }
# { platform:iOS Simulator, id:00E57628-EDEA-41F2-BC61-EB35E7B0AF96, OS:9.1, name:iPhone 5s }
# { platform:iOS Simulator, id:81C52A7B-8A5B-4346-8B23-0E6B39C95885, OS:9.2, name:iPhone 5s }
# { platform:iOS Simulator, id:F962C1E4-05EC-4F4F-AD66-A0C06534FB7D, OS:9.3, name:iPhone 5s }
# { platform:iOS Simulator, id:CE47DCD0-FB87-41F4-9C2F-6426EE78ADCA, OS:10.0, name:iPhone 5s }
# { platform:iOS Simulator, id:ACB42EC4-EC7B-4B2A-A141-763496000305, OS:10.1, name:iPhone 5s }
# { platform:iOS Simulator, id:EA4F8ED3-6D51-44AF-B833-CD2C02127FAE, OS:10.2, name:iPhone 5s }
# { platform:iOS Simulator, id:54729446-332D-4D25-AF5F-D5FC1AB010CC, OS:10.3.1, name:iPhone 5s }
# { platform:iOS Simulator, id:4134049B-90B6-49F5-8AFB-D35B486E9CBA, OS:11.0.1, name:iPhone 5s }
# { platform:iOS Simulator, id:308CD7FC-7779-4357-BABE-B24D3E84F211, OS:11.1, name:iPhone 5s }
# { platform:iOS Simulator, id:EEF36DA9-D182-4C1E-98B9-0872B759E9C7, OS:11.2, name:iPhone 5s }
# { platform:iOS Simulator, id:ADCEC684-BCFE-40DD-B68D-EB197178D5F1, OS:11.3, name:iPhone 5s }
# { platform:iOS Simulator, id:BE18B6FE-488D-4176-B0DE-F7F8F83FE775, OS:11.4, name:iPhone 5s }
# { platform:iOS Simulator, id:A1BCF2AA-7831-4E42-B015-41BC2FCDD2DF, OS:12.0, name:iPhone 5s }
# { platform:iOS Simulator, id:1AF71C95-DC20-43D8-A4DE-662D4EA6FB69, OS:12.1, name:iPhone 5s }
# { platform:iOS Simulator, id:E69E6134-E98D-4397-9845-F5A1EECF6280, OS:12.2, name:iPhone 5s }
# { platform:iOS Simulator, id:6D0A3BAF-EC5D-4C21-AA56-6059C778CEFD, OS:9.0, name:iPhone 6 }
# { platform:iOS Simulator, id:903A3009-5919-408E-82D4-176EE3AC5351, OS:9.1, name:iPhone 6 }
# { platform:iOS Simulator, id:977C47E6-6152-41B6-A78E-0A61A0447A54, OS:9.2, name:iPhone 6 }
# { platform:iOS Simulator, id:55FB789B-6292-490F-8126-609B45C08386, OS:9.3, name:iPhone 6 }
# { platform:iOS Simulator, id:A708C0A5-F78E-4067-A4B3-781944AD0225, OS:10.0, name:iPhone 6 }
# { platform:iOS Simulator, id:68BD7040-276E-4711-B0EE-4236082439E5, OS:10.1, name:iPhone 6 }
# { platform:iOS Simulator, id:1DA0F799-2AAA-4B72-940E-5D841B78772F, OS:10.2, name:iPhone 6 }
# { platform:iOS Simulator, id:7717A0A5-CA65-4C5D-A033-BE3892392F59, OS:10.3.1, name:iPhone 6 }
# { platform:iOS Simulator, id:17B0C831-D47A-4BF3-ADA8-732AFB648431, OS:11.0.1, name:iPhone 6 }
# { platform:iOS Simulator, id:9CA51BB9-F93C-4A68-8558-3D65E8311E29, OS:11.1, name:iPhone 6 }
# { platform:iOS Simulator, id:87033B86-F5B6-4802-8444-6A47CBD0C8AE, OS:11.2, name:iPhone 6 }
# { platform:iOS Simulator, id:E8B740B9-73CC-40D7-B342-07F0A180BB7E, OS:11.3, name:iPhone 6 }
# { platform:iOS Simulator, id:9D1EA86E-B76B-42F2-A6DB-356377E3A44F, OS:11.4, name:iPhone 6 }
# { platform:iOS Simulator, id:01047D8E-B0E7-4703-856C-6196BF4CEE42, OS:12.0, name:iPhone 6 }
# { platform:iOS Simulator, id:58FAF5CF-1833-4FAD-8D80-0A4838446364, OS:12.1, name:iPhone 6 }
# { platform:iOS Simulator, id:5603FC34-8017-4DB3-B3C1-4C28369B55D0, OS:12.2, name:iPhone 6 }
# { platform:iOS Simulator, id:D28AE403-689C-4ED5-A80F-D1E0E0E93657, OS:9.0, name:iPhone 6 Plus }
# { platform:iOS Simulator, id:0DE927E7-3B2F-4F75-B220-850C2E7A4691, OS:9.1, name:iPhone 6 Plus }
# { platform:iOS Simulator, id:8CB28697-AECC-4C14-B0CD-BDBE6ED6B03B, OS:9.2, name:iPhone 6 Plus }
# { platform:iOS Simulator, id:715B2E38-9927-4DAC-A592-36BB21B0144F, OS:9.3, name:iPhone 6 Plus }
# { platform:iOS Simulator, id:8BEB9C89-3E33-4F16-A41F-1EEA4A88F37F, OS:10.0, name:iPhone 6 Plus }
# { platform:iOS Simulator, id:FA4AC5F1-803B-42EA-8AF3-62B2DB2A68D4, OS:10.1, name:iPhone 6 Plus }
# { platform:iOS Simulator, id:96E3036E-E6CD-451C-BE86-F9827DF72DAA, OS:10.2, name:iPhone 6 Plus }
# { platform:iOS Simulator, id:F63CABB2-9B1E-43B5-B5FE-230E0962B812, OS:10.3.1, name:iPhone 6 Plus }
# { platform:iOS Simulator, id:C816E683-3303-47F4-AFC9-D980C0A87F6F, OS:11.0.1, name:iPhone 6 Plus }
# { platform:iOS Simulator, id:362F72F4-624C-458E-8D99-44F647BB1873, OS:11.1, name:iPhone 6 Plus }
# { platform:iOS Simulator, id:ABFB8EA0-C959-443E-8354-58028A17A8DA, OS:11.2, name:iPhone 6 Plus }
# { platform:iOS Simulator, id:F869D419-5543-4803-95E1-9E79CE38BAE1, OS:11.3, name:iPhone 6 Plus }
# { platform:iOS Simulator, id:7E658E61-E968-4957-81F9-8740B61B55CA, OS:11.4, name:iPhone 6 Plus }
# { platform:iOS Simulator, id:D213BC7D-015D-4969-AB28-F9127C6A87A1, OS:12.0, name:iPhone 6 Plus }
# { platform:iOS Simulator, id:2CC0DAC9-747A-4B75-9E0D-273E429FC64B, OS:12.1, name:iPhone 6 Plus }
# { platform:iOS Simulator, id:48145B10-C005-472D-BD2C-7371D52BD9DF, OS:12.2, name:iPhone 6 Plus }
# { platform:iOS Simulator, id:C69A4350-720E-4695-A0E8-FAE4BE5D85E4, OS:9.0, name:iPhone 6s }
# { platform:iOS Simulator, id:B9BF63EE-5AD9-432B-9A62-44A45DFFB201, OS:9.1, name:iPhone 6s }
# { platform:iOS Simulator, id:D61CFBA2-3382-464F-B638-7187EC5B5D0E, OS:9.2, name:iPhone 6s }
# { platform:iOS Simulator, id:A2253ACA-4AE7-4A4C-9F0F-31B568B30A46, OS:9.3, name:iPhone 6s }
# { platform:iOS Simulator, id:EFA82171-466D-4F71-84D3-39DFEC1464B9, OS:10.0, name:iPhone 6s }
# { platform:iOS Simulator, id:FF9EAB26-94A9-4061-BCC0-F0E435F94AB2, OS:10.1, name:iPhone 6s }
# { platform:iOS Simulator, id:CE4C545C-2B2B-461F-8B52-1F1FE7F8FD7A, OS:10.2, name:iPhone 6s }
# { platform:iOS Simulator, id:711ECDC8-1F6D-4191-9124-74B95349A933, OS:10.3.1, name:iPhone 6s }
# { platform:iOS Simulator, id:078FFD29-CF6E-48F8-B01B-AECE79946DD2, OS:11.0.1, name:iPhone 6s }
# { platform:iOS Simulator, id:DA090827-E068-4B56-8E89-ACE5B0EE9AFA, OS:11.1, name:iPhone 6s }
# { platform:iOS Simulator, id:9DA2CEF7-95E6-4C0B-A099-265786D77AD7, OS:11.2, name:iPhone 6s }
# { platform:iOS Simulator, id:1227C881-2090-42D1-860E-E02879526B87, OS:11.3, name:iPhone 6s }
# { platform:iOS Simulator, id:52F6F816-D9F8-49AE-AEDA-3B78D68770F0, OS:11.4, name:iPhone 6s }
# { platform:iOS Simulator, id:750B5BA5-47A9-4A66-8833-4E9A981A6DCE, OS:12.0, name:iPhone 6s }
# { platform:iOS Simulator, id:3E94BCE0-2596-4821-ACBD-48E87C81B499, OS:12.1, name:iPhone 6s }
# { platform:iOS Simulator, id:FDF879EC-ABD1-46EF-B79C-98EC293AD6F3, OS:12.2, name:iPhone 6s }
# { platform:iOS Simulator, id:24897424-2238-4E1D-960A-123BF2E86E3D, OS:9.0, name:iPhone 6s Plus }
# { platform:iOS Simulator, id:B30D5288-A8A3-421E-A68D-881F86B63817, OS:9.1, name:iPhone 6s Plus }
# { platform:iOS Simulator, id:92D113B2-4E97-465B-91E6-85685D68B152, OS:9.2, name:iPhone 6s Plus }
# { platform:iOS Simulator, id:BA770859-F5AA-43AD-8F3E-730F557C9D63, OS:9.3, name:iPhone 6s Plus }
# { platform:iOS Simulator, id:AC8ADAF3-4176-43C4-A6EB-D1618D618F3B, OS:10.0, name:iPhone 6s Plus }
# { platform:iOS Simulator, id:5A4BAA2D-E9B3-4D43-B7CE-008B0855B653, OS:10.1, name:iPhone 6s Plus }
# { platform:iOS Simulator, id:A859D8C7-8498-402F-AAD2-63A86BE2567D, OS:10.2, name:iPhone 6s Plus }
# { platform:iOS Simulator, id:E53AE347-1423-4B82-83B3-756D7F1972B9, OS:10.3.1, name:iPhone 6s Plus }
# { platform:iOS Simulator, id:CDDFDBAA-12D8-4C19-AF34-5A0B2ADA9D51, OS:11.0.1, name:iPhone 6s Plus }
# { platform:iOS Simulator, id:F54A9796-6BBC-469B-986F-94E6CFE1925B, OS:11.1, name:iPhone 6s Plus }
# { platform:iOS Simulator, id:9984D2FB-0649-42A1-A888-2B5EAB4C28EB, OS:11.2, name:iPhone 6s Plus }
# { platform:iOS Simulator, id:609FFCBC-0BB2-4888-AFEB-A9021942F51C, OS:11.3, name:iPhone 6s Plus }
# { platform:iOS Simulator, id:19B1FE37-ADDC-4969-AABD-3D52625F08CB, OS:11.4, name:iPhone 6s Plus }
# { platform:iOS Simulator, id:FEC0A181-AF1E-44DE-A4E7-94D87C069008, OS:12.0, name:iPhone 6s Plus }
# { platform:iOS Simulator, id:8C209285-3433-46F7-8297-8C183D1B9D5E, OS:12.1, name:iPhone 6s Plus }
# { platform:iOS Simulator, id:749AF69F-4BCE-40EE-861E-583262070F40, OS:12.2, name:iPhone 6s Plus }
# { platform:iOS Simulator, id:10787247-B228-4673-9EB7-4618D025B426, OS:10.1, name:iPhone 7 }
# { platform:iOS Simulator, id:7E3088EF-11BC-4912-B812-3B6BB15595B3, OS:10.2, name:iPhone 7 }
# { platform:iOS Simulator, id:7C560592-4F40-4E14-9BD9-A6FCD1DAAEE9, OS:10.3.1, name:iPhone 7 }
# { platform:iOS Simulator, id:C3278F00-7FD9-442B-88FC-AE4294218408, OS:11.0.1, name:iPhone 7 }
# { platform:iOS Simulator, id:C6DAC512-04EE-4C46-9DCD-4562C55FE369, OS:11.1, name:iPhone 7 }
# { platform:iOS Simulator, id:0DA3B30E-1275-4F72-9861-82D382ED4484, OS:11.2, name:iPhone 7 }
# { platform:iOS Simulator, id:E741F173-A2D1-43BD-9EE4-0638FEC27672, OS:11.3, name:iPhone 7 }
# { platform:iOS Simulator, id:6C95D4BF-21F7-4656-91F9-A6926F12F44C, OS:11.4, name:iPhone 7 }
# { platform:iOS Simulator, id:46AD6163-78AA-43BC-8D4E-1E9F7D43F188, OS:12.0, name:iPhone 7 }
# { platform:iOS Simulator, id:F41370D7-E5F5-4D91-AC3B-259CE9A83711, OS:12.1, name:iPhone 7 }
# { platform:iOS Simulator, id:CBB2E834-ABBA-4031-B8FC-E0CD199459D0, OS:12.2, name:iPhone 7 }
# { platform:iOS Simulator, id:5B4CD9F4-EB42-4028-B09E-044B4702ACF5, OS:10.1, name:iPhone 7 Plus }
# { platform:iOS Simulator, id:DF7B3BAA-3E8F-471A-A04D-70263F7D111B, OS:10.2, name:iPhone 7 Plus }
# { platform:iOS Simulator, id:0A0B26B7-73CD-4630-A25E-7CCEFC29F32F, OS:10.3.1, name:iPhone 7 Plus }
# { platform:iOS Simulator, id:D9B4DA7F-25E3-4D6D-8AA1-326EE124A5FE, OS:11.0.1, name:iPhone 7 Plus }
# { platform:iOS Simulator, id:13270229-C833-4D53-B1EA-80060DA623E3, OS:11.1, name:iPhone 7 Plus }
# { platform:iOS Simulator, id:29F488E2-0F41-429B-AFF9-25AEEFA3878F, OS:11.2, name:iPhone 7 Plus }
# { platform:iOS Simulator, id:B29AC7C8-3C5F-4FCA-B23C-51B90F5AEA68, OS:11.3, name:iPhone 7 Plus }
# { platform:iOS Simulator, id:CF406282-484A-43C0-9F5F-075713F5B5AA, OS:11.4, name:iPhone 7 Plus }
# { platform:iOS Simulator, id:788B65B7-7371-4662-A231-39A27CED43BF, OS:12.0, name:iPhone 7 Plus }
# { platform:iOS Simulator, id:FF1E05C3-E8D2-4B7A-8F44-8EF5E77C78D5, OS:12.1, name:iPhone 7 Plus }
# { platform:iOS Simulator, id:0CDFE52A-C07F-4B7E-9D43-1670E8ADFD47, OS:12.2, name:iPhone 7 Plus }
# { platform:iOS Simulator, id:367568BC-AD5E-401A-A098-827D432B68F4, OS:11.0.1, name:iPhone 8 }
# { platform:iOS Simulator, id:5EF6B1D2-868F-443E-BB9A-E76CF252D2E5, OS:11.1, name:iPhone 8 }
# { platform:iOS Simulator, id:0EDF4731-31CC-459C-9848-B16431FDDA8A, OS:11.2, name:iPhone 8 }
# { platform:iOS Simulator, id:4C789B4E-9D3B-4EAC-89BE-D6BADB368A1E, OS:11.3, name:iPhone 8 }
# { platform:iOS Simulator, id:8844DEFE-F3F6-43E1-B9FC-A4A6280D328A, OS:11.4, name:iPhone 8 }
# { platform:iOS Simulator, id:DC0D3E0B-2E9D-4B3C-82AF-49C31A841744, OS:12.0, name:iPhone 8 }
# { platform:iOS Simulator, id:EF225DA2-2D22-44DC-BBED-5801F0EA4533, OS:12.1, name:iPhone 8 }
# { platform:iOS Simulator, id:8AA5A7C2-ECFE-4128-9507-1A24F17925B6, OS:12.2, name:iPhone 8 }
# { platform:iOS Simulator, id:3022D994-A8D5-4509-B9F2-DE13FAC27DB8, OS:11.0.1, name:iPhone 8 Plus }
# { platform:iOS Simulator, id:E199FEEE-FA5C-4A72-915B-923D88B9964C, OS:11.1, name:iPhone 8 Plus }
# { platform:iOS Simulator, id:394C62AB-944D-4E5A-A41A-7B5F42F4CA01, OS:11.2, name:iPhone 8 Plus }
# { platform:iOS Simulator, id:2950AF51-A153-49E8-A5D6-575B85E4D6E5, OS:11.3, name:iPhone 8 Plus }
# { platform:iOS Simulator, id:304761EE-B701-4543-A74E-3B557FF66716, OS:11.4, name:iPhone 8 Plus }
# { platform:iOS Simulator, id:A78356A1-4C90-4699-BA30-3C7CB3546AAE, OS:12.0, name:iPhone 8 Plus }
# { platform:iOS Simulator, id:38E6C347-2229-4FD4-BEDD-0056D120BAC2, OS:12.1, name:iPhone 8 Plus }
# { platform:iOS Simulator, id:AFC0889A-F826-4E70-8CE5-DC651077A308, OS:12.2, name:iPhone 8 Plus }
# { platform:iOS Simulator, id:67C5E63A-F189-4A35-8892-C8A1AF85A137, OS:10.0, name:iPhone SE }
# { platform:iOS Simulator, id:52501CBE-DE8F-4B24-90DF-4282DE0C2175, OS:10.1, name:iPhone SE }
# { platform:iOS Simulator, id:1F0544DB-4FEB-4090-9B95-08F9DC2B9D79, OS:10.2, name:iPhone SE }
# { platform:iOS Simulator, id:AC9842E8-6C44-4D64-A5AC-1422934C85E7, OS:10.3.1, name:iPhone SE }
# { platform:iOS Simulator, id:20C2091D-23A1-4E6F-BC29-C7CAA41F63E1, OS:11.0.1, name:iPhone SE }
# { platform:iOS Simulator, id:8D8E872A-B627-4548-8DA6-D68D20255E8D, OS:11.1, name:iPhone SE }
# { platform:iOS Simulator, id:C6C8FC17-2C06-4FB2-9A8F-8C1BDA342A84, OS:11.2, name:iPhone SE }
# { platform:iOS Simulator, id:0D54C5E8-0995-4CDC-9863-998F17C191F4, OS:11.3, name:iPhone SE }
# { platform:iOS Simulator, id:C9332EDE-1CF5-44C5-AA74-463C361BEC2A, OS:11.4, name:iPhone SE }
# { platform:iOS Simulator, id:AEE6B091-1B18-49FA-85B1-085D193D10F4, OS:12.0, name:iPhone SE }
# { platform:iOS Simulator, id:9E90BDC1-467E-41EF-9E25-FBA7C143066B, OS:12.1, name:iPhone SE }
# { platform:iOS Simulator, id:EB83BF79-FEDC-4E1C-8D8B-FA44907815AB, OS:12.2, name:iPhone SE }
# { platform:iOS Simulator, id:014B8D27-8DA3-4DDF-93B0-CDC5D34372A3, OS:11.0.1, name:iPhone X }
# { platform:iOS Simulator, id:305E4DB1-ECA1-4FBB-8F1F-4835163DBFFD, OS:11.1, name:iPhone X }
# { platform:iOS Simulator, id:A97BF87F-6116-4FA4-8618-26923F6ED979, OS:11.2, name:iPhone X }
# { platform:iOS Simulator, id:493D6455-6720-4C43-86FC-8AF38E73FEF6, OS:11.3, name:iPhone X }
# { platform:iOS Simulator, id:9930437C-214D-427C-848B-9690358BD666, OS:11.4, name:iPhone X }
# { platform:iOS Simulator, id:4B2BDC5C-80B6-4E9E-A2C7-53C424DD21B6, OS:12.0, name:iPhone X }
# { platform:iOS Simulator, id:7C6D6301-B84E-4143-BF4F-45CC20C144D6, OS:12.1, name:iPhone X }
# { platform:iOS Simulator, id:B3A5F3C8-0AD6-43A1-BDB1-31A5F12448A6, OS:12.2, name:iPhone X }
# { platform:iOS Simulator, id:8D798521-2E5E-4027-835B-92CA69C6354B, OS:12.0, name:iPhone XR }
# { platform:iOS Simulator, id:0BCA4000-8510-4975-8E52-3AB1A5CDB14A, OS:12.1, name:iPhone XR }
# { platform:iOS Simulator, id:21B135A7-9D83-4B84-8499-0D44905F5B67, OS:12.0, name:iPhone XS }
# { platform:iOS Simulator, id:3090DFFF-0915-4A34-B027-C98703078789, OS:12.1, name:iPhone XS }
# { platform:iOS Simulator, id:3BB256CF-8F20-404D-A47C-A238C00BD54C, OS:12.0, name:iPhone XS Max }
# { platform:iOS Simulator, id:9B18B352-9C9C-46AB-98AA-F4B9B68E4C99, OS:12.1, name:iPhone XS Max }
# { platform:iOS Simulator, id:2D144036-DB57-4CBC-BC76-3452C2DCC7EB, OS:12.2, name:iPhone Xs }
# { platform:iOS Simulator, id:551DEA22-35ED-4E6F-9D5E-49381456096A, OS:12.2, name:iPhone Xs Max }
# { platform:iOS Simulator, id:62332DED-D4BB-47D1-AF47-E8BE8CF8D7BC, OS:12.2, name:iPhone Xʀ }
