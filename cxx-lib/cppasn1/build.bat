@echo off

md Debug
md x64
md x64\Debug

cl.exe							   	^
    /c                                                          ^
    /I..\..\ /I..\inc /I..\cppasn1                              ^
    /Z7 /nologo /W4 /WX- /Od                                    ^
    /D _DEBUG /D _USRDLL /D SNACCDLL_EXPORTS                    ^
    /D WIN32 /D _WINDOWS                                        ^
    /D _VC80_UPGRADE=0x0710 /D _WINDLL /D _MBCS                 ^
    /Gm- /EHsc /RTC1 /MDd /GS                                   ^
    /fp:precise /Zc:wchar_t /Zc:forScope                        ^
    /Fo".\Debug/" /Fd".\Debug/vc110.pdb" /FR"x64\Debug\\"       ^
    /Gd /TP /errorReport:prompt                                 ^
    "..\src\asn-any.cpp"                                        ^
    "..\src\asn-bits.cpp"                                       ^
    "..\src\asn-bool.cpp"                                       ^
    "..\src\asn-buf.cpp"                                        ^
    "..\src\asn-bufbits.cpp"                                    ^
    "..\src\asn-enum.cpp"                                       ^
    "..\src\asn-extension.cpp"                                  ^
    "..\src\asn-fileseg.cpp"                                    ^
    "..\src\asn-int.cpp"                                        ^
    "..\src\asn-len.cpp"                                        ^
    "..\src\asn-null.cpp"                                       ^
    "..\src\asn-octs.cpp"                                       ^
    "..\src\asn-oid.cpp"                                        ^
    "..\src\asn-PERGeneral.cpp"                                 ^
    "..\src\asn-real.cpp"                                       ^
    "..\src\asn-RelativeOid.cpp"                                ^
    "..\src\asn-rvsbuf.cpp"                                     ^
    "..\src\asn-stringtype.cpp"                                 ^
    "..\src\asn-tag.cpp"                                        ^
    "..\src\asn-type.cpp"                                       ^
    "..\src\asn-usefultypes.cpp"                                ^
    ..\src\hash.cpp                                             ^
    ..\src\meta.cpp                                             ^
    ..\src\print.cpp                                            ^
    ..\src\snaccexcept.cpp                                      ^
    ..\src\vda_threads2.cpp

link.exe 							^
    /ERRORREPORT:PROMPT                                         ^
    /OUT:"x64\Debug\cppasn1.dll"                                ^
    /INCREMENTAL:NO                                             ^
    /NOLOGO                                                     ^
    kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib ^
    advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib    ^
    odbc32.lib odbccp32.lib                                     ^
    /MANIFEST /MANIFESTUAC:"level='asInvoker' uiAccess='false'" ^
    /manifest:embed                                             ^
    /DEBUG                                                      ^
    /TLBID:1                                                    ^
    /DYNAMICBASE:NO                                             ^
    /IMPLIB:"x64\Debug\cppasn1.lib"                             ^
    /MACHINE:X64 /MACHINE:X64 /DLL                              ^
    ".\Debug/asn-any.obj"                                       ^
    ".\Debug/asn-bits.obj"                                      ^
    ".\Debug/asn-bool.obj"                                      ^
    ".\Debug/asn-buf.obj"                                       ^
    ".\Debug/asn-bufbits.obj"                                   ^
    ".\Debug/asn-enum.obj"                                      ^
    ".\Debug/asn-extension.obj"                                 ^
    ".\Debug/asn-fileseg.obj"                                   ^
    ".\Debug/asn-int.obj"                                       ^
    ".\Debug/asn-len.obj"                                       ^
    ".\Debug/asn-null.obj"                                      ^
    ".\Debug/asn-octs.obj"                                      ^
    ".\Debug/asn-oid.obj"                                       ^
    ".\Debug/asn-PERGeneral.obj"                                ^
    ".\Debug/asn-real.obj"                                      ^
    ".\Debug/asn-RelativeOid.obj"                               ^
    ".\Debug/asn-rvsbuf.obj"                                    ^
    ".\Debug/asn-stringtype.obj"                                ^
    ".\Debug/asn-tag.obj"                                       ^
    ".\Debug/asn-type.obj"                                      ^
    ".\Debug/asn-usefultypes.obj"                               ^
    .\Debug/hash.obj                                            ^
    .\Debug/meta.obj                                            ^
    .\Debug/print.obj                                           ^
    .\Debug/snaccexcept.obj                                     ^
    .\Debug/vda_threads2.obj

bscmake.exe        						^
    /nologo                                                     ^
    /o"x64\Debug\cppasn1.bsc"                                   ^
    "x64\Debug\asn-any.sbr"                                     ^
    "x64\Debug\asn-bits.sbr"                                    ^
    "x64\Debug\asn-bool.sbr"                                    ^
    "x64\Debug\asn-buf.sbr"                                     ^
    "x64\Debug\asn-bufbits.sbr"                                 ^
    "x64\Debug\asn-enum.sbr"                                    ^
    "x64\Debug\asn-extension.sbr"                               ^
    "x64\Debug\asn-fileseg.sbr"                                 ^
    "x64\Debug\asn-int.sbr"                                     ^
    "x64\Debug\asn-len.sbr"                                     ^
    "x64\Debug\asn-null.sbr"                                    ^
    "x64\Debug\asn-octs.sbr"                                    ^
    "x64\Debug\asn-oid.sbr"                                     ^
    "x64\Debug\asn-PERGeneral.sbr"                              ^
    "x64\Debug\asn-real.sbr"                                    ^
    "x64\Debug\asn-RelativeOid.sbr"                             ^
    "x64\Debug\asn-rvsbuf.sbr"                                  ^
    "x64\Debug\asn-stringtype.sbr"                              ^
    "x64\Debug\asn-tag.sbr"                                     ^
    "x64\Debug\asn-type.sbr"                                    ^
    "x64\Debug\asn-usefultypes.sbr"                             ^
    x64\Debug\hash.sbr                                          ^
    x64\Debug\meta.sbr                                          ^
    x64\Debug\print.sbr                                         ^
    x64\Debug\snaccexcept.sbr                                   ^
    x64\Debug\vda_threads2.sbr

