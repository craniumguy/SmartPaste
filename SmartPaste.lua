--check Firewolf installation
local fWolf = false
if browserAgent then
    if browserAgent:find("Firewolf") then
        fWolf = true
    end
else
    fWolf = false
end

--check for HTTP API
if not http then
	print("Please enable the HTTP API within the ComputerCraft configuration.")
	return
end

local devKey = "3575e50cc6635311078014a550bc3f9f"
local userKey = ""
local username = "TEMP_USER"
local password = "TEMP_PASSWORD"
local logged = false
local syntaxTab = {
    menuNames = {
        '4CS',                  '6502 ACME Cross Assembler','6502 Kick Assembler',      '6502 TASM/64TASS',
        'ABAP',                 'ActionScript',             'ActionScript 3',           'Ada',
        'ALGOL 68',             'Apache Log',               'AppleScript',              'APT Sources',
        'ARM',                  'ASM (NASM)',               'ASP',                      'Asymptote',
        'autoconf',             'Autohotkey',               'AutoIt',                   'Avisynth',
        'Awk',                  'BASCOM AVR',               'Bash',                     'Basic4GL',
        'BibTeX',               'Blitz Basic',              'BNF',                      'BOO',
        'BrainFuck',            'C',                        'C for Macs',               'C Intermediate Language',
        'C#',                   'C++',                      'C++ (with QT extensions)', 'C: Loadrunner',
        'CAD DCL',              'CAD Lisp',                 'CFDG',                     'ChaiScript',
        'Clojure',              'Clone C',                  'Clone C++',                'CMake',
        'COBOL',                'CoffeeScript',             'ColdFusion',               'CSS',
        'Cuesheet',             'D',                        'DCL',                      'DCPU-16',
        'DCS',                  'Delphi',                   'Delphi Prism (Oxygene)',   'Diff',
        'DIV',                  'DOS',                      'DOT',                      'E',
        'ECMAScript',           'Eiffel',                   'Email',                    'EPC',
        'Erlang',               'F#',                       'Falcon',                   'FO Language',
        'Formula One',          'Fortran',                  'FreeBasic',                'FreeSWITCH',
        'GAMBAS',               'Game Maker',               'GDB',                      'Genero',
        'Genie',                'GetText',                  'Go',                       'Groovy',
        'GwBasic',              'Haskell',                  'Haxe',                     'HicEst',
        'HQ9 Plus',             'HTML',                     'HTML 5',                   'Icon',
        'IDL',                  'INI file',                 'Inno Script',              'INTERCAL',
        'IO',                   'J',                        'Java',                     'Java 5',
        'JavaScript',           'jQuery',                   'KiXtart',                  'Latex',
        'LDIF',                 'Liberty BASIC',            'Linden Scripting',         'Lisp',
        'LLVM',                 'Loco Basic',               'Logtalk',                  'LOL Code',
        'Lotus Formulas',       'Lotus Script',             'LScript',                  'Lua',
        'M68000 Assembler',     'MagikSF',                  'Make',                     'MapBasic',
        'MatLab',               'mIRC',                     'MIX Assembler',            'Modula 2',
        'Modula 3',             'Motorola 68000 HiSoft Dev','MPASM',                    'MXML',
        'MySQL',                'Nagios',                   'newLISP',                  'None',
        'NullSoft Installer',   'Oberon 2',                 'Objeck Programming Langua','Objective C',
        'OCalm Brief',          'OCaml',                    'Octave',                   'OpenBSD PACKET FILTER',
        'OpenGL Shading',       'Openoffice BASIC',         'Oracle 11',                'Oracle 8',
        'Oz',                   'ParaSail',                 'PARI/GP',                  'Pascal',
        'PAWN',                 'PCRE',                     'Per',                      'Perl',
        'Perl 6',               'PHP',                      'PHP Brief',                'Pic 16',
        'Pike',                 'Pixel Bender',             'PL/SQL',                   'PostgreSQL',
        'POV-Ray',              'Power Shell',              'PowerBuilder',             'ProFTPd',
        'Progress',             'Prolog',                   'Properties',               'ProvideX',
        'PureBasic',            'PyCon',                    'Python',                   'Python for S60',
        'q/kdb+',               'QBasic',                   'R',                        'Rails',
        'REBOL',                'REG',                      'Rexx',                     'Robots',
        'RPM Spec',             'Ruby',                     'Ruby Gnuplot',             'SAS',
        'Scala',                'Scheme',                   'Scilab',                   'SdlBasic',
        'Smalltalk',            'Smarty',                   'SPARK',                    'SPARQL',
        'SQL',                  'StoneScript',              'SystemVerilog',            'T-SQL',
        'TCL',                  'Tera Term',                'thinBasic',                'TypoScript',
        'Unicon',               'UnrealScript',             'UPC',                      'Urbi',
        'Vala',                 'VB.NET',                   'Vedit',                    'VeriLog',
        'VHDL',                 'VIM',                      'Visual Pro Log',           'VisualBasic',
        'VisualFoxPro',         'WhiteSpace',               'WHOIS',                    'Winbatch',
        'XBasic',               'XML',                      'Xorg Config',              'XPP',
        'YAML',                 'Z80 Assembler',            'ZXBasic'
        },
    urlCodes = {
        '4cs',                  '6502acme',                 '6502kickass',              '6502tasm',
        'abap',                 'actionscript',             'actionscript3',            'ada',
        'algol68',              'apache',                   'applescript',              'apt_sources',
        'arm',                  'asm',                      'asp',                      'asymptote',
        'autoconf',             'autohotkey',               'autoit',                   'avisynth',
        'awk',                  'bascomavr',                'bash',                     'basic4gl',
        'bibtex',               'blitzbasic',               'bnf',                      'boo',
        'bf',                   'c',                        'c_mac',                    'cil',
        'csharp',               'cpp',                      'cpp-qt',                   'c_loadrunner',
        'caddcl',               'cadlisp',                  'cfdg',                     'chaiscript',
        'clojure',              'klonec',                   'klonecpp',                 'cmake',
        'cobol',                'coffeescript',             'cfm',                      'css',
        'cuesheet',             'd',                        'dcl',                      'dcpu16',
        'dcs',                  'delphi',                   'oxygene',                  'diff',
        'div',                  'dos',                      'dot',                      'e',
        'ecmascript',           'eiffel',                   'email',                    'epc',
        'erlang',               'fsharp',                   'falcon',                   'fo',
        'f1',                   'fortran',                  'freebasic',                'freeswitch',
        'gambas',               'gml',                      'gdb',                      'genero',
        'genie',                'gettext',                  'go',                       'groovy',
        'gwbasic',              'haskell',                  'haxe',                     'hicest',
        'hq9plus',              'html4strict',              'html5',                    'icon',
        'idl',                  'ini',                      'inno',                     'intercal',
        'io',                   'j',                        'java',                     'java5',
        'javascript',           'jquery',                   'kixtart',                  'latex',
        'ldif',                 'lb',                       'lsl2',                     'lisp',
        'llvm',                 'locobasic',                'logtalk',                  'lolcode',
        'lotusformulas',        'lotusscript',              'lscript',                  'lua',
        'm68k',                 'magiksf',                  'make',                     'mapbasic',
        'matlab',               'mirc',                     'mmix',                     'modula2',
        'modula3',              '68000devpac',              'mpasm',                    'mxml',
        'mysql',                'nagios',                   'newlisp',                  'text',
        'nsis',                 'oberon2',                  'objeck',                   'objc',
        'ocaml-brief',          'ocaml',                    'octave',                   'pf',
        'glsl',                 'oobas',                    'oracle11',                 'oracle8',
        'oz',                   'parasail',                 'parigp',                   'pascal',
        'pawn',                 'pcre',                     'per',                      'perl',
        'perl6',                'php',                      'php-brief',                'pic16',
        'pike',                 'pixelbender',              'plsql',                    'postgresql',
        'povray',               'powershell',               'powerbuilder',             'proftpd',
        'progress',             'prolog',                   'properties',               'providex',
        'purebasic',            'pycon',                    'python',                   'pys60',
        'q',                    'qbasic',                   'rsplus',                   'rails',
        'rebol',                'reg',                      'rexx',                     'robots',
        'rpmspec',              'ruby',                     'gnuplot',                  'sas',
        'scala',                'scheme',                   'scilab',                   'sdlbasic',
        'smalltalk',            'smarty',                   'spark',                    'sparql',
        'sql',                  'stonescript',              'systemverilog',            'tsql',
        'tcl',                  'teraterm',                 'thinbasic',                'typoscript',
        'unicon',               'uscript',                  'ups',                      'urbi',
        'vala',                 'vbnet',                    'vedit',                    'verilog',
        'vhdl',                 'vim',                      'visualprolog',             'vb',
        'visualfoxpro',         'whitespace',               'whois',                    'winbatch',
        'xbasic',               'xml',                      'xorg_conf',                'xpp',
        'yaml',                 'z80',                      'zxbasic'
        }
    }

local logo = {[1]={[1]=0,[2]=0,[3]=128,[4]=128,[5]=128,[6]=128,[7]=128,[8]=128,[9]=128,[10]=128,[11]=128,[12]=128,[13]=128,[14]=128,[15]=128,[16]=128,[17]=0,[18]=0,[19]=0,[20]=0,[21]=0,[22]=0,[23]=0,[24]=0,[25]=0,[26]=0,[27]=0,[28]=0,[29]=0,[30]=0,[31]=0,[32]=0,[33]=0,[34]=0,[35]=0,[36]=0,[37]=0,[38]=0,[39]=0,[40]=0,[41]=0,[42]=0,[43]=0,[44]=0,[45]=0,[46]=0,[47]=0,[48]=0,[49]=0,},[2]={[1]=0,[2]=128,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[10]=1,[11]=1,[12]=1,[13]=1,[14]=1,[15]=1,[16]=1,[17]=128,[18]=0,[19]=0,[20]=0,[21]=0,[22]=0,[23]=0,[24]=0,[25]=0,[26]=0,[27]=0,[28]=0,[29]=0,[30]=0,[31]=0,[32]=0,[33]=0,[34]=0,[35]=0,[36]=0,[37]=0,[38]=0,[39]=0,[40]=0,[41]=0,[42]=0,[43]=0,[44]=0,[45]=0,[46]=0,[47]=0,[48]=0,[49]=0,},[3]={[1]=128,[2]=1,[3]=1,[4]=1,[5]=8,[6]=8,[7]=8,[8]=1,[9]=1,[10]=1,[11]=1,[12]=1,[13]=32,[14]=1,[15]=1,[16]=1,[17]=1,[18]=128,[19]=0,[20]=0,[21]=0,[22]=0,[23]=0,[24]=0,[25]=0,[26]=0,[27]=0,[28]=0,[29]=0,[30]=0,[31]=0,[32]=0,[33]=0,[34]=0,[35]=0,[36]=0,[37]=0,[38]=0,[39]=0,[40]=0,[41]=0,[42]=0,[43]=0,[44]=0,[45]=0,[46]=0,[47]=0,[48]=0,[49]=0,},[4]={[1]=128,[2]=1,[3]=1,[4]=8,[5]=1,[6]=1,[7]=1,[8]=8,[9]=1,[10]=1,[11]=1,[12]=32,[13]=32,[14]=32,[15]=1,[16]=1,[17]=1,[18]=128,[19]=0,[20]=0,[21]=0,[22]=0,[23]=0,[24]=0,[25]=0,[26]=0,[27]=0,[28]=0,[29]=0,[30]=0,[31]=0,[32]=0,[33]=0,[34]=0,[35]=0,[36]=0,[37]=0,[38]=0,[39]=0,[40]=0,[41]=0,[42]=0,[43]=0,[44]=0,[45]=0,[46]=0,[47]=0,[48]=0,[49]=0,},[5]={[1]=128,[2]=1,[3]=1,[4]=8,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[10]=1,[11]=32,[12]=32,[13]=32,[14]=32,[15]=32,[16]=1,[17]=1,[18]=128,[19]=0,[20]=0,[21]=0,[22]=0,[23]=0,[24]=0,[25]=0,[26]=0,[27]=0,[28]=0,[29]=0,[30]=0,[31]=0,[32]=0,[33]=0,[34]=0,[35]=0,[36]=0,[37]=0,[38]=0,[39]=0,[40]=0,[41]=0,[42]=0,[43]=0,[44]=0,[45]=0,[46]=0,[47]=0,[48]=0,[49]=0,},[6]={[1]=128,[2]=1,[3]=1,[4]=1,[5]=8,[6]=8,[7]=8,[8]=1,[9]=1,[10]=1,[11]=1,[12]=1,[13]=32,[14]=1,[15]=1,[16]=1,[17]=1,[18]=128,[19]=0,[20]=0,[21]=0,[22]=0,[23]=0,[24]=0,[25]=0,[26]=0,[27]=0,[28]=0,[29]=0,[30]=0,[31]=0,[32]=0,[33]=0,[34]=0,[35]=0,[36]=0,[37]=0,[38]=0,[39]=0,[40]=0,[41]=0,[42]=0,[43]=0,[44]=0,[45]=0,[46]=0,[47]=0,[48]=0,[49]=0,},[7]={[1]=128,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=8,[9]=1,[10]=1,[11]=1,[12]=1,[13]=32,[14]=1,[15]=1,[16]=1,[17]=1,[18]=128,[19]=0,[20]=0,[21]=0,[22]=0,[23]=0,[24]=0,[25]=0,[26]=0,[27]=0,[28]=0,[29]=0,[30]=0,[31]=0,[32]=0,[33]=0,[34]=0,[35]=0,[36]=0,[37]=0,[38]=0,[39]=0,[40]=0,[41]=0,[42]=0,[43]=0,[44]=0,[45]=0,[46]=0,[47]=0,[48]=0,[49]=0,},[8]={[1]=128,[2]=1,[3]=1,[4]=8,[5]=1,[6]=1,[7]=1,[8]=8,[9]=1,[10]=1,[11]=1,[12]=1,[13]=1,[14]=1,[15]=1,[16]=1,[17]=1,[18]=128,[19]=0,[20]=0,[21]=0,[22]=0,[23]=0,[24]=0,[25]=0,[26]=0,[27]=0,[28]=0,[29]=0,[30]=0,[31]=0,[32]=0,[33]=0,[34]=0,[35]=0,[36]=0,[37]=0,[38]=0,[39]=0,[40]=0,[41]=0,[42]=0,[43]=0,[44]=0,[45]=0,[46]=0,[47]=0,[48]=0,[49]=0,},[9]={[1]=128,[2]=1,[3]=1,[4]=1,[5]=8,[6]=8,[7]=8,[8]=1,[9]=1,[10]=1,[11]=2048,[12]=2048,[13]=2048,[14]=2048,[15]=1,[16]=1,[17]=1,[18]=128,[19]=0,[20]=0,[21]=0,[22]=0,[23]=0,[24]=0,[25]=0,[26]=0,[27]=0,[28]=0,[29]=0,[30]=0,[31]=0,[32]=0,[33]=0,[34]=0,[35]=0,[36]=0,[37]=0,[38]=0,[39]=0,[40]=0,[41]=0,[42]=0,[43]=0,[44]=0,[45]=0,[46]=0,[47]=0,[48]=0,[49]=0,},[10]={[1]=128,[2]=1,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[10]=1,[11]=2048,[12]=1,[13]=1,[14]=1,[15]=2048,[16]=1,[17]=1,[18]=128,[19]=0,[20]=0,[21]=0,[22]=0,[23]=0,[24]=0,[25]=0,[26]=0,[27]=0,[28]=0,[29]=0,[30]=0,[31]=0,[32]=0,[33]=0,[34]=0,[35]=0,[36]=0,[37]=0,[38]=0,[39]=0,[40]=0,[41]=0,[42]=0,[43]=0,[44]=0,[45]=0,[46]=0,[47]=0,[48]=0,[49]=0,},[11]={[1]=128,[2]=1,[3]=1,[4]=1,[5]=1,[6]=2,[7]=1,[8]=1,[9]=1,[10]=1,[11]=2048,[12]=1,[13]=1,[14]=1,[15]=2048,[16]=1,[17]=1,[18]=128,[19]=0,[20]=0,[21]=0,[22]=0,[23]=0,[24]=0,[25]=0,[26]=0,[27]=0,[28]=0,[29]=0,[30]=0,[31]=0,[32]=0,[33]=0,[34]=0,[35]=0,[36]=0,[37]=0,[38]=0,[39]=0,[40]=0,[41]=0,[42]=0,[43]=0,[44]=0,[45]=0,[46]=0,[47]=0,[48]=0,[49]=0,},[12]={[1]=128,[2]=1,[3]=1,[4]=1,[5]=1,[6]=2,[7]=1,[8]=1,[9]=1,[10]=1,[11]=2048,[12]=2048,[13]=2048,[14]=2048,[15]=1,[16]=1,[17]=1,[18]=128,[19]=0,[20]=0,[21]=0,[22]=0,[23]=0,[24]=0,[25]=0,[26]=0,[27]=0,[28]=0,[29]=0,[30]=0,[31]=0,[32]=0,[33]=0,[34]=0,[35]=0,[36]=0,[37]=0,[38]=0,[39]=0,[40]=0,[41]=0,[42]=0,[43]=0,[44]=0,[45]=0,[46]=0,[47]=0,[48]=0,[49]=0,},[13]={[1]=128,[2]=1,[3]=1,[4]=2,[5]=2,[6]=2,[7]=2,[8]=2,[9]=1,[10]=1,[11]=2048,[12]=1,[13]=1,[14]=1,[15]=1,[16]=1,[17]=1,[18]=128,[19]=0,[20]=0,[21]=0,[22]=0,[23]=0,[24]=0,[25]=0,[26]=0,[27]=0,[28]=0,[29]=0,[30]=0,[31]=0,[32]=0,[33]=0,[34]=0,[35]=0,[36]=0,[37]=0,[38]=0,[39]=0,[40]=0,[41]=0,[42]=0,[43]=0,[44]=0,[45]=0,[46]=0,[47]=0,[48]=0,[49]=0,},[14]={[1]=128,[2]=1,[3]=1,[4]=1,[5]=2,[6]=2,[7]=2,[8]=1,[9]=1,[10]=1,[11]=2048,[12]=1,[13]=1,[14]=1,[15]=1,[16]=1,[17]=1,[18]=128,[19]=0,[20]=0,[21]=0,[22]=0,[23]=0,[24]=0,[25]=0,[26]=0,[27]=0,[28]=0,[29]=0,[30]=0,[31]=0,[32]=0,[33]=0,[34]=0,[35]=0,[36]=0,[37]=0,[38]=0,[39]=0,[40]=0,[41]=0,[42]=0,[43]=0,[44]=0,[45]=0,[46]=0,[47]=0,[48]=0,[49]=0,},[15]={[1]=128,[2]=1,[3]=1,[4]=1,[5]=1,[6]=2,[7]=1,[8]=1,[9]=1,[10]=1,[11]=2048,[12]=1,[13]=1,[14]=1,[15]=1,[16]=1,[17]=1,[18]=128,[19]=0,[20]=0,[21]=0,[22]=0,[23]=0,[24]=0,[25]=0,[26]=0,[27]=0,[28]=0,[29]=0,[30]=0,[31]=0,[32]=0,[33]=0,[34]=0,[35]=0,[36]=0,[37]=0,[38]=0,[39]=0,[40]=0,[41]=0,[42]=0,[43]=0,[44]=0,[45]=0,[46]=0,[47]=0,[48]=0,[49]=0,},[16]={[1]=0,[2]=128,[3]=1,[4]=1,[5]=1,[6]=1,[7]=1,[8]=1,[9]=1,[10]=1,[11]=1,[12]=1,[13]=1,[14]=1,[15]=1,[16]=1,[17]=128,[18]=0,[19]=0,[20]=0,[21]=0,[22]=0,[23]=0,[24]=0,[25]=0,[26]=0,[27]=0,[28]=0,[29]=0,[30]=0,[31]=0,[32]=0,[33]=0,[34]=0,[35]=0,[36]=0,[37]=0,[38]=0,[39]=0,[40]=0,[41]=0,[42]=0,[43]=0,[44]=0,[45]=0,[46]=0,[47]=0,[48]=0,[49]=0,},[17]={[1]=0,[2]=0,[3]=128,[4]=128,[5]=128,[6]=128,[7]=128,[8]=128,[9]=128,[10]=128,[11]=128,[12]=128,[13]=128,[14]=128,[15]=128,[16]=128,},}

local codec = {[1]={[1]=128,[2]=128,[3]=128,[4]=128,[5]=128,[6]=128,[7]=128,[8]=128,[9]=128,[10]=128,[11]=128,[12]=128,[13]=128,[14]=128,[15]=128,[16]=128,[17]=128,[18]=128,[19]=128,[20]=128,[21]=128,[22]=128,[23]=128,[24]=128,[25]=128,[26]=128,[27]=128,[28]=128,[29]=128,[30]=128,[31]=128,[32]=128,[33]=128,[34]=128,[35]=128,[36]=128,[37]=128,[38]=128,[39]=128,[40]=128,[41]=128,[42]=128,[43]=128,[44]=128,[45]=128,[46]=128,[47]=128,[48]=128,[49]=128,[50]=128,[51]=128,},[2]={[1]=128,[2]=32768,[3]=32768,[4]=32768,[5]=32768,[6]=32768,[7]=32768,[8]=32768,[9]=32768,[10]=32768,[11]=32768,[12]=128,[13]=32768,[14]=8192,[15]=32768,[16]=8192,[17]=8192,[18]=8192,[19]=8192,[20]=8192,[21]=8192,[22]=32768,[23]=32768,[24]=32768,[25]=32768,[26]=32768,[27]=32768,[28]=32768,[29]=32768,[30]=32768,[31]=32768,[32]=32768,[33]=32768,[34]=32768,[35]=32768,[36]=32768,[37]=32768,[38]=32768,[39]=32768,[40]=128,[41]=32768,[42]=32768,[43]=32768,[44]=32768,[45]=32768,[46]=32768,[47]=32768,[48]=32768,[49]=32768,[50]=32768,[51]=128,},[3]={[1]=128,[2]=32768,[3]=32768,[4]=32768,[5]=32768,[6]=32768,[7]=32768,[8]=32768,[9]=32768,[10]=32768,[11]=32768,[12]=128,[13]=32768,[14]=32768,[15]=32768,[16]=32768,[17]=32768,[18]=32768,[19]=32768,[20]=32768,[21]=32768,[22]=32768,[23]=1,[24]=1,[25]=32768,[26]=1,[27]=32768,[28]=1,[29]=32768,[30]=1,[31]=1,[32]=32768,[33]=32768,[34]=1,[35]=1,[36]=32768,[37]=1,[38]=1,[39]=1,[40]=128,[41]=32768,[42]=32768,[43]=32768,[44]=32768,[45]=32768,[46]=32768,[47]=32768,[48]=32768,[49]=32768,[50]=32768,[51]=128,},[4]={[1]=128,[2]=32768,[3]=32768,[4]=32768,[5]=32768,[6]=32768,[7]=32768,[8]=32768,[9]=32768,[10]=32768,[11]=32768,[12]=128,[13]=32768,[14]=8192,[15]=32768,[16]=8192,[17]=8192,[18]=8192,[19]=8192,[20]=32768,[21]=32768,[22]=32768,[23]=32768,[24]=1,[25]=32768,[26]=1,[27]=32768,[28]=1,[29]=32768,[30]=32768,[31]=1,[32]=32768,[33]=32768,[34]=32768,[35]=1,[36]=32768,[37]=32768,[38]=32768,[39]=1,[40]=128,[41]=32768,[42]=32768,[43]=32768,[44]=32768,[45]=32768,[46]=32768,[47]=32768,[48]=32768,[49]=32768,[50]=32768,[51]=128,},[5]={[1]=128,[2]=32768,[3]=32768,[4]=32768,[5]=32768,[6]=32768,[7]=32768,[8]=32768,[9]=32768,[10]=32768,[11]=32768,[12]=128,[13]=32768,[14]=32768,[15]=32768,[16]=32768,[17]=32768,[18]=32768,[19]=32768,[20]=32768,[21]=32768,[22]=32768,[23]=32768,[24]=1,[25]=32768,[26]=1,[27]=1,[28]=1,[29]=32768,[30]=32768,[31]=1,[32]=32768,[33]=32768,[34]=32768,[35]=1,[36]=32768,[37]=1,[38]=1,[39]=1,[40]=128,[41]=32768,[42]=32768,[43]=32768,[44]=32768,[45]=32768,[46]=32768,[47]=32768,[48]=32768,[49]=32768,[50]=32768,[51]=128,},[6]={[1]=128,[2]=32768,[3]=32768,[4]=32768,[5]=32768,[6]=32768,[7]=32768,[8]=32768,[9]=32768,[10]=32768,[11]=32768,[12]=128,[13]=32768,[14]=8192,[15]=32768,[16]=8192,[17]=8192,[18]=32768,[19]=32768,[20]=32768,[21]=32768,[22]=32768,[23]=32768,[24]=1,[25]=32768,[26]=32768,[27]=32768,[28]=1,[29]=32768,[30]=32768,[31]=1,[32]=32768,[33]=32768,[34]=32768,[35]=1,[36]=32768,[37]=1,[38]=32768,[39]=32768,[40]=128,[41]=32768,[42]=32768,[43]=32768,[44]=32768,[45]=32768,[46]=32768,[47]=32768,[48]=32768,[49]=32768,[50]=32768,[51]=128,},[7]={[1]=128,[2]=32768,[3]=32768,[4]=32768,[5]=32768,[6]=32768,[7]=32768,[8]=32768,[9]=32768,[10]=32768,[11]=32768,[12]=128,[13]=32768,[14]=32768,[15]=32768,[16]=32768,[17]=32768,[18]=32768,[19]=32768,[20]=32768,[21]=32768,[22]=32768,[23]=32768,[24]=1,[25]=32768,[26]=32768,[27]=32768,[28]=1,[29]=32768,[30]=32768,[31]=1,[32]=32768,[33]=1,[34]=32768,[35]=1,[36]=32768,[37]=1,[38]=1,[39]=1,[40]=128,[41]=32768,[42]=32768,[43]=32768,[44]=32768,[45]=32768,[46]=32768,[47]=32768,[48]=32768,[49]=32768,[50]=32768,[51]=128,},[8]={[1]=128,[2]=128,[3]=128,[4]=128,[5]=128,[6]=128,[7]=128,[8]=128,[9]=128,[10]=128,[11]=128,[12]=128,[13]=128,[14]=128,[15]=128,[16]=128,[17]=128,[18]=128,[19]=128,[20]=128,[21]=128,[22]=128,[23]=128,[24]=128,[25]=128,[26]=128,[27]=128,[28]=128,[29]=128,[30]=128,[31]=128,[32]=128,[33]=128,[34]=128,[35]=128,[36]=128,[37]=128,[38]=128,[39]=128,[40]=128,[41]=128,[42]=128,[43]=128,[44]=128,[45]=128,[46]=128,[47]=128,[48]=128,[49]=128,[50]=128,[51]=128,},[9]={[1]=32768,[2]=32768,[3]=32768,[4]=32768,[5]=32768,[6]=32768,[7]=32768,[8]=32768,[9]=32768,[10]=32768,[11]=32768,[12]=32768,[13]=32768,[14]=32768,[15]=32768,[16]=32768,[17]=32768,[18]=32768,[19]=32768,[20]=32768,[21]=32768,[22]=32768,[23]=32768,[24]=32768,[25]=32768,[26]=32768,[27]=32768,[28]=32768,[29]=32768,[30]=32768,[31]=32768,[32]=32768,[33]=32768,[34]=32768,[35]=32768,[36]=32768,[37]=32768,[38]=32768,[39]=32768,[40]=32768,[41]=32768,[42]=32768,[43]=32768,[44]=32768,[45]=32768,[46]=32768,[47]=32768,[48]=32768,[49]=32768,[50]=32768,[51]=32768,},[10]={[1]=32768,[2]=256,[3]=256,[4]=256,[5]=256,[6]=256,[7]=256,[8]=256,[9]=256,[10]=256,[11]=256,[12]=256,[13]=256,[14]=256,[15]=256,[16]=256,[17]=256,[18]=256,[19]=256,[20]=256,[21]=256,[22]=256,[23]=256,[24]=256,[25]=256,[26]=256,[27]=256,[28]=256,[29]=256,[30]=256,[31]=256,[32]=256,[33]=256,[34]=256,[35]=256,[36]=256,[37]=256,[38]=256,[39]=256,[40]=256,[41]=256,[42]=256,[43]=256,[44]=256,[45]=256,[46]=256,[47]=256,[48]=256,[49]=256,[50]=256,[51]=32768,},[11]={[1]=32768,[2]=256,[3]=32768,[4]=32768,[5]=32768,[6]=32768,[7]=32768,[8]=32768,[9]=32768,[10]=32768,[11]=32768,[12]=32768,[13]=32768,[14]=32768,[15]=32768,[16]=32768,[17]=32768,[18]=32768,[19]=32768,[20]=32768,[21]=32768,[22]=32768,[23]=32768,[24]=32768,[25]=32768,[26]=32768,[27]=32768,[28]=32768,[29]=32768,[30]=32768,[31]=32768,[32]=32768,[33]=32768,[34]=32768,[35]=32768,[36]=32768,[37]=32768,[38]=32768,[39]=32768,[40]=32768,[41]=32768,[42]=32768,[43]=32768,[44]=32768,[45]=32768,[46]=32768,[47]=32768,[48]=32768,[49]=32768,[50]=256,[51]=32768,},[12]={[1]=32768,[2]=256,[3]=32768,[4]=32768,[5]=32768,[6]=32768,[7]=32768,[8]=32768,[9]=32768,[10]=32768,[11]=32768,[12]=32768,[13]=32768,[14]=32768,[15]=32768,[16]=32768,[17]=32768,[18]=32768,[19]=32768,[20]=32768,[21]=32768,[22]=32768,[23]=32768,[24]=32768,[25]=32768,[26]=32768,[27]=32768,[28]=32768,[29]=32768,[30]=32768,[31]=32768,[32]=32768,[33]=32768,[34]=32768,[35]=32768,[36]=32768,[37]=32768,[38]=32768,[39]=32768,[40]=32768,[41]=32768,[42]=32768,[43]=32768,[44]=32768,[45]=32768,[46]=32768,[47]=32768,[48]=32768,[49]=32768,[50]=256,[51]=32768,},[13]={[1]=32768,[2]=256,[3]=32768,[4]=32768,[5]=32768,[6]=32768,[7]=32768,[8]=32768,[9]=32768,[10]=32768,[11]=32768,[12]=32768,[13]=32768,[14]=32768,[15]=32768,[16]=32768,[17]=32768,[18]=32768,[19]=32768,[20]=32768,[21]=32768,[22]=32768,[23]=32768,[24]=32768,[25]=32768,[26]=32768,[27]=32768,[28]=32768,[29]=32768,[30]=32768,[31]=32768,[32]=32768,[33]=32768,[34]=32768,[35]=32768,[36]=32768,[37]=32768,[38]=32768,[39]=32768,[40]=32768,[41]=32768,[42]=32768,[43]=32768,[44]=32768,[45]=32768,[46]=32768,[47]=32768,[48]=32768,[49]=32768,[50]=256,[51]=32768,},[14]={[1]=32768,[2]=256,[3]=32768,[4]=32768,[5]=32768,[6]=32768,[7]=32768,[8]=32768,[9]=32768,[10]=32768,[11]=32768,[12]=32768,[13]=32768,[14]=32768,[15]=32768,[16]=32768,[17]=32768,[18]=32768,[19]=32768,[20]=32768,[21]=32768,[22]=32768,[23]=32768,[24]=32768,[25]=32768,[26]=32768,[27]=32768,[28]=32768,[29]=32768,[30]=32768,[31]=32768,[32]=32768,[33]=32768,[34]=32768,[35]=32768,[36]=32768,[37]=32768,[38]=32768,[39]=32768,[40]=32768,[41]=32768,[42]=32768,[43]=32768,[44]=32768,[45]=32768,[46]=32768,[47]=32768,[48]=32768,[49]=32768,[50]=256,[51]=32768,},[15]={[1]=32768,[2]=256,[3]=32768,[4]=32768,[5]=32768,[6]=32768,[7]=32768,[8]=32768,[9]=32768,[10]=32768,[11]=32768,[12]=32768,[13]=32768,[14]=32768,[15]=32768,[16]=32768,[17]=32768,[18]=32768,[19]=32768,[20]=32768,[21]=32768,[22]=32768,[23]=32768,[24]=32768,[25]=32768,[26]=32768,[27]=32768,[28]=32768,[29]=32768,[30]=32768,[31]=32768,[32]=32768,[33]=32768,[34]=32768,[35]=32768,[36]=32768,[37]=32768,[38]=32768,[39]=32768,[40]=32768,[41]=32768,[42]=32768,[43]=32768,[44]=32768,[45]=32768,[46]=32768,[47]=32768,[48]=32768,[49]=32768,[50]=256,[51]=32768,},[16]={[1]=32768,[2]=256,[3]=256,[4]=256,[5]=256,[6]=256,[7]=256,[8]=256,[9]=256,[10]=256,[11]=256,[12]=256,[13]=256,[14]=256,[15]=256,[16]=256,[17]=256,[18]=256,[19]=256,[20]=256,[21]=256,[22]=256,[23]=256,[24]=256,[25]=256,[26]=256,[27]=256,[28]=256,[29]=256,[30]=256,[31]=256,[32]=256,[33]=256,[34]=256,[35]=256,[36]=256,[37]=256,[38]=256,[39]=256,[40]=256,[41]=256,[42]=256,[43]=256,[44]=256,[45]=256,[46]=256,[47]=256,[48]=256,[49]=256,[50]=256,[51]=32768,},[17]={[1]=32768,[2]=32768,[3]=32768,[4]=32768,[5]=32768,[6]=32768,[7]=32768,[8]=32768,[9]=32768,[10]=32768,[11]=32768,[12]=32768,[13]=32768,[14]=32768,[15]=32768,[16]=32768,[17]=32768,[18]=32768,[19]=32768,[20]=32768,[21]=32768,[22]=32768,[23]=32768,[24]=32768,[25]=32768,[26]=32768,[27]=32768,[28]=32768,[29]=32768,[30]=32768,[31]=32768,[32]=32768,[33]=32768,[34]=32768,[35]=32768,[36]=32768,[37]=32768,[38]=32768,[39]=32768,[40]=32768,[41]=32768,[42]=32768,[43]=32768,[44]=32768,[45]=32768,[46]=32768,[47]=32768,[48]=32768,[49]=32768,[50]=32768,[51]=32768,},}

--check for arguments
local function usage()
	print("Usage:")
	print(shell.getRunningProgram().." <get> <pastebin code> <save file> [username]")
	print(shell.getRunningProgram().." <put> <save file> [username]")
	print("Required: < >")
	print("Optional: [ ]")
end

local tArgs = {...}
if #tArgs >= 2 and #tArgs <= 4 then
	if tArgs[1] == "get" then
		print("Retrieving from url: http://pastebin.com/"..tArgs[2])
		print("Saving to file: "..tArgs[3])
		if #tArgs[2] > 8 or #tArgs[2] < 8 then
			print("Invalid Pastebin code!")
			return
		else
			print("Connecting to Pastebin...")
			local site = http.get("http://pastebin.com/raw.php?i="..tArgs[2])
			if not site then
				print("Unable to connect to Pastebin!")
				return
			else
				print("Connected! Reading url contents...")
				local siteContent = site.readAll()
				if not fs.exists(tArgs[3]) then
					local file = fs.open(tArgs[3], "w")
					file.write(siteContent)
					file.close()
					print("Download complete! Saved as '"..tArgs[3].."'")
					return
				else
					print("File already exists!")
					return
				end
			end
		end
	elseif tArgs[1] == "put" then
		local badResponses = {
			"Bad API request, IP blocked",
			"Bad API request, api_paste_code was empty",
			"Bad API request, maximum paste file size exceeded"
			}
		if not fs.exists(tArgs[2]) then
			print("No file exists!")
			return
		else
			if not tArgs[3] then
				print("Reading file...")
				local file = fs.open(tArgs[2], "r")
				local postText = file.readAll()
				file.close()
				local postName = tArgs[2]

				local response = http.post(
					"http://pastebin.com/api/api_post.php", 
					"api_option=paste&"..
					"api_dev_key="..devKey.."&"..
					"api_paste_format=lua&"..
					"api_paste_name="..textutils.urlEncode(postName).."&"..
					"api_paste_code="..textutils.urlEncode(postText)
					).readAll()
				if response then
					for i = 1, #badResponses do
						if response == badResponses[i] then
							print(badResponses[i])
							return
						else
							print("Save successful! File stored at:\n"..response)
							return
						end
					end
				else
					print("Unable to connect to Pastebin! Please try again.")
				end
			else
				print("Using private authentication. Password required!")
				write("Password: ")
				local password = read("*")
				local response = http.post(
					"http://pastebin.com/api/api_login.php",
					"api_dev_key="..devKey.."&"..
					"api_user_name="..textutils.urlEncode(tArgs[3]).."&"..
					"api_user_password="..textutils.urlEncode(password)
					).readAll()

				local badRequests = {
					"Bad API request, invalid login",
					"Bad API request, account not active"
					}
				
				if response == badRequests[1] then
					print("Invalid login!")
					return
				elseif response == badRequests[2] then
					print("Inactive account!")
					return
				else
					local userKey = response
					print("Reading file...")
					local file = fs.open(tArgs[2], "r")
					local postText = file.readAll()
					file.close()
					local postName = tArgs[2]
					local response = http.post(
					"http://pastebin.com/api/api_post.php", 
						"api_option=paste&"..
						"api_dev_key="..devKey.."&"..
						"api_user_key="..userKey.."&"..
						"api_paste_format=lua&"..
						"api_paste_private=0&"..
						"api_paste_name="..textutils.urlEncode(postName).."&"..
						"api_paste_code="..textutils.urlEncode(postText)
						).readAll()

					if response then
						for i = 1, #badResponses do
							if response == badResponses[i] then
								print(badResponses[i])
								return
							else
								print("Save successful! File stored at:\n"..response)
								return
							end
						end
					else
						print("Unable to connect to Pastebin! Please try again.")
					end
				end
			end
		end
	else
		usage()
		return
	end
end

--Throw relevant errors
local x,y = term.getSize()
if turtle or not term.isColor() or x ~= 51 and y ~= 19 then
    print("Please run this program from commandline prompts.")
    usage()
    return
end

local function checkCode()
    local kCode = {200, 200, 208, 208, 203, 205, 203, 205, 48, 30, 28}
    local extraCode = {200, 200, 208, 208, 203, 205, 203, 205, "b", "a", 28}
    local eventTab = {"key", "key", "key", "key", "key", "key", "key", "key", "char", "char", "key"}
    local code = false
    local index = 1
    while true do
        local events = {os.pullEvent()}
        --[[for i = 1, #events do
            term.setCursorPos(20, 5 + i)
            write(events[i].." / "..i.. " / "..index)
            sleep(1)
        end]]
        sleep(0)
        if index == #kCode then
            code = true
            term.setCursorPos(7,2)
            term.setBackgroundColor(colors.lightGray)
            term.setTextColor(colors.red)
            write("Code entry successful")
            break
        else
            code = false
        end
        if events[1] == "char" then
            if events[2] == kCode[index] or events[2] == extraCode[index] then
                index = index + 1
            else
                code = false
                break
            end
        elseif events[1] == "key" then
            if events[2] == kCode[index] or events[2] == extraCode[index] then
                index = index + 1
            else
                code = false
                break
            end
        elseif events[1] ~= "key" and events[1] ~= "char" then
            os.queueEvent(unpack(events))
            break
        end
    end
    return code
end

local function unlock()
    paintutils.drawImage(codec, 1, 3)
    for i = 3, 10 do
        term.setTextColor(colors.lightGray)
        term.setBackgroundColor(colors.black)
        term.setCursorPos(1, i)
        write("|")
        term.setCursorPos(12, i)
        write("|")
        term.setCursorPos(40, i)
        write("|")
        term.setCursorPos(51, i)
        write("|")
        term.setCursorPos(1, i)
        write(i == 3 and "+"..string.rep("-", 10).."+"..string.rep("-", 27).."+"..string.rep("-", 10).."+" or i == 10 and "+"..string.rep("-", 10).."+"..string.rep("-", 27).."+"..string.rep("-", 10).."+" or "")
    end
    for i = 12, 18 do
        term.setTextColor(colors.lightGray)
        term.setBackgroundColor(colors.black)
        term.setCursorPos(2, i)
        write(i == 12 and "+"..string.rep("-", 47).."+" or i == 18 and "+"..string.rep("-", 47).."+" or "|")
        term.setCursorPos(50, i)
        write("|")
    end
    local talking = true
    local function static()
        while talking do
            local staticColors = {
                    colors.white,
                    colors.gray,
                    colors.black,
                    colors.lightGray}
            for i = 2, 11 do
                for k = 4, 9 do
                    local cx, cy = term.getCursorPos()
                    term.setCursorPos(i, k)
                    term.setBackgroundColor(staticColors[math.random(1,4)])
                    write(" ")
                    term.setCursorPos(cx, cy)
                    term.setBackgroundColor(colors.black)
                end
            end
            for i = 41, 50 do
                for k = 4, 9 do
                    local cx, cy = term.getCursorPos()
                    term.setCursorPos(i, k)
                    term.setBackgroundColor(staticColors[math.random(1,4)])
                    write(" ")
                    term.setCursorPos(cx, cy)
                    term.setBackgroundColor(colors.black)
                end
            end
            sleep(.01)
        end
    end
    local function writeText()
        local chatTab = {
            {"Unknown voice 1: The user has found the",
             "    backdoor. Shall I terminate the connection",
             "    to the server?"},
            {"Unknown voice 2: No. Their diligence has paid",
             "    off. Give them more tests. Scatter them",
             "    throughout cyberspace. Let's see if they",
             "    can find all of the clues."},
            {"Unknown voice 1: Understood sir."}
            }

        term.setBackgroundColor(colors.black)
        term.setTextColor(colors.white)
        for i = 1, #chatTab do
            for k = 1, #chatTab[i] do
                term.setCursorPos(4, 12 + k)
                term.setBackgroundColor(colors.black)
                term.setTextColor(colors.white)
                textutils.slowWrite(chatTab[i][k], 10)
            end
            sleep(2)
            for v = 13, 17 do
                paintutils.drawLine(3, v, 49, v, colors.black)
            end
        end
        talking = false
    end
    
    parallel.waitForAll(static, writeText)
    sleep(1)
    background()
end

-- limit read function
local function limitRead(limX, rChar)
    local origX, origY = term.getCursorPos()
    term.setBackgroundColor(colors.white)
    term.setTextColor(colors.blue)
    term.setCursorPos(origX, origY)
    term.setCursorBlink(true)
    local returnString = ""
    while true do
        local xPos, yPos = term.getCursorPos()
        local events = {os.pullEvent()}
        if events[1] == "char" then
            returnString = returnString..events[2]
            if not rChar then
                if not limX then
                    term.setTextColor(colors.blue)
                    write(events[2])
                else
                    if string.len(returnString) >= limX then
                        term.setTextColor(colors.blue)
                        term.setCursorPos(origX, origY)
                        write(string.sub(returnString, (string.len(returnString)-limX)+1))
                    elseif string.len(returnString) < limX then
                        term.setTextColor(colors.blue)
                        write(events[2])
                    end
                end
            else
                if not limX then
                    term.setTextColor(colors.blue)
                    write(rChar)
                else
                    if string.len(returnString) >= limX then
                        term.setTextColor(colors.blue)
                        term.setCursorPos(origX, origY)
                        write(string.rep(rChar, limX))
                    elseif string.len(returnString) < limX then
                        term.setTextColor(colors.blue)
                        write(rChar)
                    end
                end
            end
        elseif events[1] == "key" and events[2] == 14 then --backspace
            returnString = string.sub(returnString, 1, (string.len(returnString))-1)
            term.setCursorPos(xPos-1,yPos)
            term.setTextColor(colors.blue)
            write(" ")
            term.setCursorPos(origX, origY)
            if string.len(returnString) >= limX then
                if not rChar then
                    term.setTextColor(colors.blue)
                    write(string.sub(returnString, (string.len(returnString)-limX)+1))
                else
                    term.setTextColor(colors.blue)
                    write(string.rep(rChar,limX))
                end
            else
                if not rChar then
                    term.setTextColor(colors.blue)
                    write(returnString)
                else
                    term.setTextColor(colors.blue)
                    write(string.rep(rChar, string.len(returnString)))
                end
            end
        elseif events[1] == "key" and events[2] == 28 then --enter
            break
        elseif events[1] == "mouse_click" and events[2] == 1 then
            if events[3] >= 15 and events[3] <= 19 and events[4] == 13 and login == true then --"login"
                break
            elseif events[3] >= 30 and events[3] <= 35 and events[4] == 13 and login == true then --"cancel"
                returnString = "EXIT LOGIN"
                break
            elseif events[3] >= 21 and events[3] <= 28 and events[4] == 11 and downloading == true then --download(not logged)
                os.queueEvent(unpack(events))
                break
            elseif events[3] >= 1 and events[3] <= 5 and events[4] == 2 then
                returnString = login and "EXIT LOGIN" or ""
                os.queueEvent(unpack(events))
                break
            elseif events[3] >= 21 and events[3] <= 24 and events[4] == 2 then
                returnString = login and "EXIT LOGIN" or ""
                os.queueEvent(unpack(events))
                break
            elseif events[3] >= 28 and events[3] <= 31 and events[4] == 2 then
                returnString = login and "EXIT LOGIN" or ""
                os.queueEvent(unpack(events))
                break
            elseif events[3] >= 34 and events[3] <= 42 and events[4] == 2 then
                returnString = login and "EXIT LOGIN" or ""
                os.queueEvent(unpack(events))
                break
            elseif events[3] >= 45 and events[3] <= 49 and events[4] == 2 then
                returnString = login and "EXIT LOGIN" or ""
                os.queueEvent(unpack(events))
                break
            elseif events[3] == x and events[4] == 1 then
                term.setBackgroundColor(colors.black)
                term.setTextColor(colors.white)
                term.clear()
                term.setCursorPos(1,1)
                print("Thank you for using SmartPaste!")
                os.queueEvent("terminate")
                returnString = "TERMINATE"
                break
            end
        end
    end
    term.setCursorBlink(false)
    return returnString
end

local function loginScript()
    if not logged then
        paintutils.drawLine(10,6,40,6, colors.blue)
        term.setCursorPos(10, 6)
        term.setTextColor(colors.white)
        term.setBackgroundColor(colors.blue)
        write("Please login")
        for i = 1, 8 do
            paintutils.drawLine(10, 6 + i, 40, 6 + i, colors.lightGray)
        end
        local loginObjects = {
            {name = "Username:",
            nameX = 11,
            nameY = 9,
            color = colors.black,
            BGcolor = colors.lightGray},
            {name = "Username:         ",
            nameX = 21,
            nameY = 9,
            color = colors.white,
            BGcolor = colors.white},
            {name = "Password:",
            nameX = 11,
            nameY = 11,
            color = colors.black,
            BGcolor = colors.lightGray},
            {name = "Password:         ",
            nameX = 21,
            nameY = 11,
            color = colors.white,
            BGcolor = colors.white},
            {name = "Login",
            nameX = 15,
            nameY = 13,
            color = colors.white,
            BGcolor = colors.green},
            {name = "Cancel",
            nameX = 30,
            nameY = 13,
            color = colors.white,
            BGcolor = colors.red}
            }

        while true do
            for i = 1, #loginObjects do
                term.setCursorPos(loginObjects[i].nameX, loginObjects[i].nameY)
                term.setTextColor(loginObjects[i].color)
                term.setBackgroundColor(loginObjects[i].BGcolor)
                write(loginObjects[i].name)
            end

            term.setCursorPos(22, 9)
            login = true
            username = limitRead(16)
            if username ~= "EXIT LOGIN" and username ~= "TERMINATE" then
                term.setCursorPos(22, 11)
                password = limitRead(16, "*")
                if password ~= "EXIT LOGIN" and username ~= "TERMINATE" then
                    local response = http.post(
                        "http://pastebin.com/api/api_login.php",
                        "api_dev_key="..devKey.."&"..
                        "api_user_name="..textutils.urlEncode(username).."&"..
                        "api_user_password="..textutils.urlEncode(password)
                        ).readAll()
                
                    local badRequests = {
                        "Bad API request, invalid login",
                        "Bad API request, account not active"
                        }
                    if response then
                        if response == badRequests[1] then
                            term.setCursorPos(11,7)
                            term.setBackgroundColor(colors.lightGray)
                            term.setTextColor(colors.red)
                            write("Invalid login!")
                        elseif response == badRequests[2] then
                            term.setCursorPos(11,7)
                            term.setBackgroundColor(colors.lightGray)
                            term.setTextColor(colors.red)
                            write("Inactive account!")
                        else
                            userKey = response
                            logged = true
                            background()
                            break
                        end
                    end
                elseif password == "TERMINATE" then
                    os.queueEvent("terminate")
                    break
                elseif password == "EXIT LOGIN" then
                    password = "TEMP_PASSWORD"
                    background()
                    break
                else
                    userKey = ""
                    logged = false
                    background()
                    break
                end
            elseif username == "TERMINATE" then
                os.queueEvent("terminate")
                break
            elseif username == "EXIT LOGIN" then
                username = "TEMP_USER"
                background()
                break
            else
                userKey = ""
                logged = false
                background()
                break
            end
        end
        login = false
    else
        logged = false
        userKey = ""
        background()
    end
end

local function helpScreen()
    for i = 3, y do
        paintutils.drawLine(1,i,x,i,colors.lightBlue)
    end
    for i = 6, y-3 do
        paintutils.drawLine(28,i,x-1,i,colors.white)
    end
    term.setBackgroundColor(colors.lightBlue)
    term.setTextColor(colors.black)
    term.setCursorPos(15,4)
    write("SmartPaste Help Section")
    term.setCursorPos(45,2)
    term.setBackgroundColor(colors.red)
    term.setTextColor(colors.black)
    write("Help")
    term.setCursorPos(1,6)
    term.setTextColor(colors.white)
    term.setBackgroundColor(colors.lightBlue)
    write([[    Please select from a
    topic on the right.
    Help information will
    be displayed here.]])
    local helpMenu = {
        {topic = "How to login",
        y = 7,
        action = function()
                for i = 6, y do
                    paintutils.drawLine(1,i,27,i,colors.lightBlue)
                end
                term.setCursorPos(8,6)
                term.setTextColor(colors.black)
                term.setBackgroundColor(colors.lightBlue)
                print("How to login")
                term.setTextColor(colors.white)
                write([[
 Select the "Login" option
at the top. You will enter
your personal login for 
your pastebin account.

 Rest assured, your account
information is not stored
anywhere. We use a user
key once we receive a 
successful login from
Pastebin.]])
            end},
        {topic = "How to retrieve a post",
        y = 8,
        action = function()
                for i = 6, y do
                    paintutils.drawLine(1,i,27,i,colors.lightBlue)
                end
                term.setCursorPos(3,6)
                term.setTextColor(colors.black)
                term.setBackgroundColor(colors.lightBlue)
                print("How to retrieve a post")
                term.setTextColor(colors.white)
                write([[
 Select "Download" from the
menu.

If you are logged in, you
willbe able to view your
own posts or download
directly from a paste
code.

Otherwise, you can just
download directly using a
paste code.]])
            end},
        {topic = "How to save a post",
        y = 9,
        action = function()
                for i = 6, y do
                    paintutils.drawLine(1,i,27,i,colors.lightBlue)
                end
                term.setCursorPos(5,6)
                term.setTextColor(colors.black)
                term.setBackgroundColor(colors.lightBlue)
                print("How to save a post")
                term.setTextColor(colors.white)
                write([[
 Select 'New' from the main
menu at the top. From there
you can scroll through the
files you have on your
computer/turtle. Use the
Enter key to make your
selection.
 You have the option of
changing the syntax
of your paste, expiration,
and if you are logged in,
even the exposure.]])
            end},
        {topic = "What's new",
        y = 10,
        action = function()
                for i = 6, y do
                    paintutils.drawLine(1,i,27,i,colors.lightBlue)
                end
                term.setCursorPos(9,6)
                term.setTextColor(colors.black)
                term.setBackgroundColor(colors.lightBlue)
                print("What's new")
                term.setTextColor(colors.white)
                write([[
-You are now able to select
 the syntax highlighting
 that is posted to Pastebin
 as well as changing the 
 paste expiry date. You can
 also change how the post
 is published, to public,
 private, or unlisted.
-Obvious graphic changes.
-Automatic integration with
 Firewolf.
-A secret! Try to find it!!]])
            end},
        {topic = "Credits",
        y = 11,
        action = function()
                for i = 6, y do
                    paintutils.drawLine(1,i,27,i,colors.lightBlue)
                end
                term.setCursorPos(12,6)
                term.setTextColor(colors.black)
                term.setBackgroundColor(colors.lightBlue)
                print("Credits")
                term.setTextColor(colors.white)
                write([[
Code -- Cranium
Design -- Cranium
Logo -- Cranium
Firewolf -- 1Lann and
         Gravityscore
Bug Fixing -- CC Forums
Logo Idea -- RunasSudo
    Special thanks to 1Lann
and Gravityscore for giving
me the idea to redo the
whole thing, and making it
so much better.]])
            end},
        {topic = "About",
        y = 12,
        action = function()
                for i = 6, y do
                    paintutils.drawLine(1,i,27,i,colors.lightBlue)
                end
                term.setCursorPos(12,6)
                term.setTextColor(colors.black)
                term.setBackgroundColor(colors.lightBlue)
                print("About")
                term.setTextColor(colors.white)
                write([[
      -Version 2.0-
 Written for ComputerCraft
       ver. 1.48+
 This awesome program was
written by Cranium, and use
of this program is granted
under these two conditions:

 Any modifications must
be approved by the original
author and credit cannot be
claimed by the user.]])
            end}
        }
    local help = true
    while help do
        for i = 1, 6 do
            term.setCursorPos(29, 6 + i)
            term.setTextColor(colors.blue)
            term.setBackgroundColor(colors.white)
            write(helpMenu[i].topic)
        end
        local events = {os.pullEvent()}
        if events[1] == "mouse_click" and events[2] == 1 then
            for i = 1, #helpMenu do
                if events[3] >= 29 and events[3] <= x-1 then
                    if events[4] == helpMenu[i].y then
                        helpMenu[i].action()
                    end
                end
            end
            if events[4] == 2 then
                if events[3] >= 1 and events[3] <= 5 then
                    os.queueEvent(unpack(events))
                    break
                elseif events[3] >= 21 and events[3] <= 24 then
                    os.queueEvent(unpack(events))
                    break
                elseif events[3] >= 28 and events[3] <= 31 then
                    os.queueEvent(unpack(events))
                    break
                elseif events[3] >= 34 and events[3] <= 42 then
                    os.queueEvent(unpack(events))
                    break
                elseif events[3] >= 45 and events[3] <= 49 then
                    os.queueEvent(unpack(events))
                    break
                end
            elseif events[4] == 1 and events[3] == x then
                os.queueEvent("terminate")
                break
            end
        end
    end
end

local function downloadPaste()
    for i = 3, y do
        paintutils.drawLine(1,i,x,i,colors.lightBlue)
    end
    if logged then
        for i = 9, 12 do
            paintutils.drawLine(10,i,40,i,colors.white)
        end
        term.setCursorPos(15,10)
        term.setTextColor(colors.blue)
        write("Retrieving posts for:")
        local cX = (x/2)-(string.len(username)/2)
        term.setCursorPos(cX,11)
        term.setTextColor(colors.red)
        write(username)

        local response = http.post(
            "http://pastebin.com/api/api_post.php", 
            "api_option=list&"..
            "api_dev_key="..devKey.."&"..
            "api_user_key="..userKey
            ).readAll()

        if not response then
            for i = 6,10 do
                paintutils.drawLine(8,i,42,i,colors.lightGray)
            end
            paintutils.drawLine(9,8,41,8,colors.white)
            term.setCursorPos(11,8)
            term.setTextColor(colors.red)
            write("Unable to connect to Pastebin!")
        end

        for i = 3, y do
            paintutils.drawLine(1,i,x,i,colors.lightBlue)
        end

        local codeTable = {}
        local titleTable = {}
        local formatTable = {}
        local privTable = {}
        for code in string.gmatch(response, "<paste_key>(%w-)</paste_key>") do
            table.insert(codeTable, code)
        end
        for title in string.gmatch(response, "<paste_title>(.-)</paste_title>") do
            table.insert(titleTable, title)
        end
        for formatLong in string.gmatch(response, "<paste_format_long>(%w-)</paste_format_long>") do
            table.insert(formatTable, formatLong)
        end
        for private in string.gmatch(response, "<paste_private>(%d-)</paste_private>") do
            if private == "0" then
                table.insert(privTable, "Public")
            elseif private == "1" then
                table.insert(privTable, "Unlisted")
            elseif private == "2" then
                table.insert(privTable, "Private")
            end
        end

        if not codeTable[1] then
            for i = 9, 12 do
                paintutils.drawLine(10,i,40,i,colors.white)
            end
            term.setCursorPos(18, 10)
            term.setTextColor(colors.red)
            write("No pastes found!")
            sleep(1)
            return
        end

        term.setBackgroundColor(colors.lightBlue)
        term.setCursorPos(2, 4)
        term.setTextColor(colors.black)
        write("Title")
        term.setCursorPos(19, 4)
        write("Syntax")
        term.setCursorPos(30, 4)
        write("Paste Type")
        term.setCursorPos(2, 14)
        term.setBackgroundColor(colors.lightBlue)
        term.setTextColor(colors.black)
        write("Selected Paste Info:")
        for k = 15, y do
            paintutils.drawLine(2,k,25,k,colors.lightGray)
        end
        term.setCursorPos(10, 18)
        term.setBackgroundColor(colors.green)
        write("Download")
        for k = 15, y do
            paintutils.drawLine(27,k,50,k,colors.lightGray)
        end
        term.setCursorPos(35, 18)
        term.setBackgroundColor(colors.green)
        write("Download")
        term.setCursorPos(27, 14)
        term.setBackgroundColor(colors.lightBlue)
        write("Enter Pastebin Code:")
        paintutils.drawLine(28,16,49,16,colors.white)

        local scroll = 1
        while true do
            local function drawList(titleTable, formatTable, scroll)
                if scroll <= 8 then
                    for i = 1, 8 do
                        if i > #titleTable then break end
                        if titleTable[1] == nil then break end
                        term.setBackgroundColor(colors.lightBlue)
                        term.setCursorPos(1, 4 + i)
                        term.setTextColor(colors.white)
                        if string.len(titleTable[i]) >= 17 then
                            write(" "..string.sub(titleTable[i], 1, 14).."...") 
                        else
                            write(" "..titleTable[i])
                        end
                        local mX,mY = term.getCursorPos()
                        for i = 1, 19 - mX do
                            write(" ")
                        end
                        write(formatTable[i])
                        local mX,mY = term.getCursorPos()
                        for i = 1, 30 - mX do
                            write(" ")
                        end
                        write(privTable[i])
                        local mX,mY = term.getCursorPos()
                        for i = 1, 50 - mX do
                            write(" ")
                        end
                    end
                    term.setCursorPos(1, 4 + scroll)
                    term.setTextColor(colors.red)
                    if string.len(titleTable[scroll]) >= 17 then
                        write(">"..string.sub(titleTable[scroll], 1, 14).."...")
                    else
                        write(">"..titleTable[scroll])
                    end
                    local mX,mY = term.getCursorPos()
                    for i = 1, 19 - mX do
                        write(" ")
                    end
                else
                    for i = 1, 8 do
                        if i > #titleTable then break end
                        term.setBackgroundColor(colors.lightBlue)
                        term.setCursorPos(1, 4 + i)
                        term.setTextColor(colors.white)
                        if string.len(titleTable[scroll + (i - 8)]) >= 17 then
                            write(" "..string.sub(titleTable[scroll + (i - 8)], 1, 14).."...") 
                        else
                            write(" "..titleTable[scroll + (i - 8)])
                        end
                        local mX,mY = term.getCursorPos()
                        for i = 1, 19 - mX do
                            write(" ")
                        end
                            write(formatTable[scroll + (i - 8)])
                        local mX,mY = term.getCursorPos()
                        for i = 1, 30 - mX do
                            write(" ")
                        end
                        write(privTable[scroll + (i - 8)])
                        local mX,mY = term.getCursorPos()
                        for i = 1, 50 - mX do
                            write(" ")
                        end
                    end
                    term.setCursorPos(1, 12)
                    term.setTextColor(colors.red)
                    if string.len(titleTable[scroll]) >= 17 then
                        write(">"..string.sub(titleTable[scroll], 1, 14).."...")
                    else
                        write(">"..titleTable[scroll])
                    end
                    local mX,mY = term.getCursorPos()
                    for i = 1, 19 - mX do
                        write(" ")
                    end
                end
                paintutils.drawLine(3, 16, 24, 16, colors.white)
                term.setCursorPos(3, 16)
                term.setTextColor(colors.blue)
                if string.len(titleTable[scroll]) >= 19 then
                    write(string.sub(titleTable[scroll], 1, 19).."...")
                else
                    write(titleTable[scroll])
                end
            end

            drawList(titleTable, formatTable, scroll)
            local events = {os.pullEvent()}
            if events[1] == "mouse_scroll" then
                if events[2] == 1 then
                    if scroll >= #titleTable then
                        scroll = #titleTable
                    elseif scroll >= 1 and scroll < #titleTable then
                        scroll = scroll + 1
                        drawList(titleTable, formatTable, scroll)
                    end
                elseif events[2] == -1 then
                    if scroll <= 1 then
                        scroll = 1
                    elseif scroll >= 1 then
                        scroll = scroll - 1
                        drawList(titleTable, formatTable, scroll)
                    end
                end
            elseif events[1] == "key" then
                if events[2] == 208 then
                    if scroll >= #titleTable then
                        scroll = #titleTable
                    elseif scroll >= 1 and scroll < #titleTable then
                        scroll = scroll + 1
                        drawList(titleTable, formatTable, scroll)
                    end
                elseif events[2] == 200 then
                    if scroll <= 1 then
                        scroll = 1
                    elseif scroll >= 1 then
                        scroll = scroll - 1
                        drawList(titleTable, formatTable, scroll)
                    end
                end
            elseif events[1] == "char" then
                for i = 1, #titleTable do
                    if string.lower(string.sub(titleTable[i], 1, 1)) == events[2] then
                        scroll = i
                        break
                    end
                    drawList(titleTable, formatTable, scroll)
                end
            elseif events[1] == "mouse_click" and events[2] == 1 then
                if events[3] >= 28 and events[3] <= 49 and events[4] == 16 then
                    paintutils.drawLine(28,16,49,16,colors.white)
                    term.setCursorPos(29,16)
                    DLcode = read()
                elseif events[3] >= 35 and events[3] <= 42 and events[4] == 18 then
                    if DLcode ~= "" and DLcode ~= nil then
                        local DLcontent = http.get("http://pastebin.com/raw.php?i="..DLcode)
                        if not DLcontent then
                            for k = 6, 8 do
                                paintutils.drawLine(10,k,40,k, colors.lightGray)
                            end
                            term.setCursorPos(11,7)
                            term.setTextColor(colors.red)
                            write("Unable to connect to Pastebin!")
                        else
                            newFile = DLcontent.readAll()
                        end
                        for k = 6, 9 do
                            paintutils.drawLine(10,k,40,k, colors.lightGray)
                        end
                        paintutils.drawLine(11,8,39,8,colors.white)
                        term.setCursorPos(11,6)
                        term.setBackgroundColor(colors.lightGray)
                        term.setTextColor(colors.black)
                        write("Please enter new filename:")
                        term.setCursorPos(12,8)
                        term.setTextColor(colors.blue)
                        term.setBackgroundColor(colors.white)
                        local fName = read()
                        if fName ~= "" and fName ~= nil then 
                            if not fs.exists(fName) then
                                local file = fs.open(fName, "w")
                                file.write(newFile)
                                file.close()
                                for k = 6, 8 do
                                    paintutils.drawLine(10,k,40,k, colors.lightGray)
                                end
                                term.setCursorPos(11,7)
                                term.setTextColor(colors.red)
                                write("Download Successful!")
                                sleep(1)
                                DLcode = false
                                for i = 5, 12 do
                                    paintutils.drawLine(1, i, 50, i, colors.lightBlue)
                                end
                            else
                                term.setCursorPos(11,7)
                                term.setTextColor(colors.red)
                                print("FILE EXISTS!")
                                sleep(1)
                                for i = 5, 12 do
                                    paintutils.drawLine(1, i, 50, i, colors.lightBlue)
                                end
                            end
                        end
                    end
                elseif events[3] >= 10 and events[3] <= 17 and events[4] == 18 then
                    local DLcontent = http.get("http://pastebin.com/raw.php?i="..codeTable[scroll])
                    if not DLcontent then
                        for k = 6, 8 do
                            paintutils.drawLine(10,k,40,k, colors.lightGray)
                        end
                        term.setCursorPos(11,7)
                        term.setTextColor(colors.red)
                        write("Unable to connect to Pastebin!")
                    else
                        newFile = DLcontent.readAll()
                    end
                    for k = 6, 9 do
                        paintutils.drawLine(10,k,40,k, colors.lightGray)
                    end
                    paintutils.drawLine(11,8,39,8,colors.white)
                    term.setCursorPos(11,6)
                    term.setBackgroundColor(colors.lightGray)
                    term.setTextColor(colors.black)
                    write("Please enter new filename:")
                    term.setCursorPos(12,8)
                    term.setTextColor(colors.blue)
                    term.setBackgroundColor(colors.white)
                    local fName = read()
                    if fName ~= "" and fName ~= nil then 
                        if not fs.exists(fName) then
                            local file = fs.open(fName, "w")
                            file.write(newFile)
                            file.close()
                            for k = 6, 8 do
                                paintutils.drawLine(10,k,40,k, colors.lightGray)
                            end
                            term.setCursorPos(11,7)
                            term.setTextColor(colors.red)
                            write("Download Successful!")
                            sleep(1)
                            DLcode = false
                            for i = 5, 12 do
                                paintutils.drawLine(1, i, 50, i, colors.lightBlue)
                            end
                        else
                            term.setCursorPos(11,7)
                            term.setTextColor(colors.red)
                            print("FILE EXISTS!")
                            sleep(1)
                            for i = 5, 12 do
                                paintutils.drawLine(1, i, 50, i, colors.lightBlue)
                            end
                        end
                    end
                elseif events[4] == 2 then
                    if events[3] >= 1 and events[3] <= 5 then
                        os.queueEvent(unpack(events))
                        break
                    elseif events[3] >= 21 and events[3] <= 24 then
                        os.queueEvent(unpack(events))
                        break
                    elseif events[3] >= 28 and events[3] <= 31 then
                        os.queueEvent(unpack(events))
                        break
                    elseif events[3] >= 34 and events[3] <= 42 then
                        os.queueEvent(unpack(events))
                        break
                    elseif events[3] >= 45 and events[3] <= 49 then
                        os.queueEvent(unpack(events))
                        break
                    end
                elseif events[3] == x and events[4] == 1 then
                    os.queueEvent("terminate")
                    break
                end
            end
        end
    else
        for i = 7,11 do
            paintutils.drawLine(15,i,35,i,colors.lightGray)
        end
        term.setCursorPos(16,7)
        term.setTextColor(colors.black)
        write("Enter Pastebin Code")
        term.setBackgroundColor(colors.green)
        term.setCursorPos(21,11)
        write("Download")
        paintutils.drawLine(16,9,34,9,colors.white)
        term.setCursorPos(17,9)
        term.setTextColor(colors.blue)
        downloading = true
        local PBcode = limitRead(17)
        if PBcode ~= "" then
            while true do
                local events = {os.pullEvent()}
                if events[1] == "mouse_click" and events[2] == 1 then
                    if events[3] >= 21 and events[3] <= 28 and events[4] == 11 then
                        if PBcode ~= "TERMINATE" then
                            paintutils.drawLine(16,9,34,9,colors.white)
                            paintutils.drawLine(15,7,35,7,colors.lightGray)
                            term.setCursorPos(16,7)
                            term.setTextColor(colors.black)
                            write("Enter new Filename:")
                            term.setCursorPos(17,9)
                            local fName = limitRead(17)
                            if fName ~= "" then
                                local site = http.get("http://pastebin.com/raw.php?i="..PBcode)
                                if site then
                                    local pasteContent = site.readAll()
                                    local file = fs.open(fName, "w")
                                    file.write(pasteContent)
                                    file.close()
                                    background()
                                    break
                                end
                            end
                        else
                            os.queueEvent("terminate")
                            break
                        end
                    elseif events[4] == 2 then
                        if events[3] >= 1 and events[3] <= 5 then
                            os.queueEvent(unpack(events))
                            break
                        elseif events[3] >= 21 and events[3] <= 24 then
                            os.queueEvent(unpack(events))
                            break
                        elseif events[3] >= 28 and events[3] <= 31 then
                            os.queueEvent(unpack(events))
                            break
                        elseif events[3] >= 34 and events[3] <= 42 then
                            os.queueEvent(unpack(events))
                            break
                        elseif events[3] >= 45 and events[3] <= 49 then
                            os.queueEvent(unpack(events))
                            break
                        end
                    elseif events[3] == x and events[4] == 1 then
                        os.queueEvent("terminate")
                        break
                    end
                end
            end
        end
        downloading = false
    end
end

local function newPaste()
    local optsTab = {
        "Syntax highlighting:",
        "Paste expiration:",
        "Paste exposure:",
        "Show hidden files:"
        }
    local expiryTab = {
        "Never",
        "10 minutes",
        "1 hour",
        "1 day",
        "1 month"
        }
    local expTabList = {
        'N',
        '10M',
        '1H',
        '1D',
        '1M'
        }
    local exposureTab = {
        "Public",
        "Private",
        "Unlisted"
        }
    local scroll = 1
    local synOpt = 128
    local expOpt = 1
    local pubOpt = 1
    local dirTab = {""}
    local hidden = false

    for i = 3, y do
        paintutils.drawLine(1,i,x,i,colors.lightBlue)
    end
    term.setBackgroundColor(colors.lightBlue)
    term.setCursorPos(2, 4)
    term.setTextColor(colors.black)
    write("File")
    term.setCursorPos(19, 4)
    write("Type")
    term.setCursorPos(30, 4)
    write("File Size")
    for k = 14, y do
        paintutils.drawLine(2,k,50,k,colors.lightGray)
    end
    for i = 1, 4 do
        term.setTextColor(colors.black)
        term.setBackgroundColor(colors.lightGray)
        paintutils.drawLine(2, 14 + i, 50, 14 + i, colors.lightGray)
        term.setCursorPos(3, 14 + i)
        write(optsTab[i])
    end
    
    local function getFiles(dir, hidden)
        local rTab = {}
        for _, v in pairs(fs.list(dir)) do
            if hidden == true then
                table.insert(rTab, v)
            else
                if string.sub(v, 1, 1) ~= "." then
                    table.insert(rTab, v)
                end
            end
        end
        return rTab
    end

    while true do
        local listTable = getFiles(table.concat(dirTab, "/"), hidden)
        local typeTable = {}
        local sizeTable = {}

        for i = 1, #listTable do
            if fs.isDir(table.concat(dirTab, "/").."/"..listTable[i]) then
                table.insert(listTable, 1, listTable[i])
                table.remove(listTable, i + 1)
                table.insert(typeTable, 1, "Folder")
                table.insert(sizeTable, 1, "")
            else
                table.insert(typeTable, "File")
                table.insert(sizeTable, fs.getSize(table.concat(dirTab, "/").."/"..listTable[i]).." Bytes")
            end
        end
        table.insert(listTable, 1, "Return")
        table.insert(typeTable, 1, "")
        table.insert(sizeTable, 1, "")
        
        -- list files on computer
        local function drawList(dirTab, listTable, scroll)
            if scroll <= 8 then
                for i = 1, 8 do
                    if i > #listTable then break end
                    term.setBackgroundColor(colors.lightBlue)
                    term.setCursorPos(1, 4 + i)
                    if fs.isDir(table.concat(dirTab, "/").."/"..listTable[i]) then
                        term.setTextColor(colors.lime)
                    elseif listTable[i] == "Return" then
                        term.setTextColor(colors.green)
                    else
                        term.setTextColor(colors.white)
                    end
                    if string.len(listTable[i]) >= 17 then
                        write(" "..string.sub(listTable[i], 1, 14).."...") 
                    else
                        write(" "..listTable[i])
                    end
                    local mX,mY = term.getCursorPos()
                    for i = 1, 19 - mX do
                        write(" ")
                    end
                    write(typeTable[i])
                    local mX,mY = term.getCursorPos()
                    for i = 1, 30 - mX do
                        write(" ")
                    end
                    write(sizeTable[i])
                    local mX,mY = term.getCursorPos()
                    for i = 1, 50 - mX do
                        write(" ")
                    end
                end
                term.setCursorPos(1, 4 + scroll)
                term.setTextColor(colors.red)
                if string.len(listTable[scroll]) >= 17 then
                    write(">"..string.sub(listTable[scroll], 1, 14).."...")
                else
                    write(">"..listTable[scroll])
                end
                local mX,mY = term.getCursorPos()
                for i = 1, 19 - mX do
                    write(" ")
                end
            else
                for i = 1, 8 do
                    if i > #listTable then break end
                    term.setBackgroundColor(colors.lightBlue)
                    term.setCursorPos(1, 4 + i)
                    if fs.isDir(table.concat(dirTab, "/").."/"..listTable[scroll + (i - 8)]) then
                        term.setTextColor(colors.lime)
                    elseif listTable[scroll + (i - 8)] == "Return" then
                        term.setTextColor(colors.green)
                    else
                        term.setTextColor(colors.white)
                    end
                    if string.len(listTable[scroll + (i - 8)]) >= 17 then
                        write(" "..string.sub(listTable[scroll + (i - 8)], 1, 14).."...") 
                    else
                        write(" "..listTable[scroll + (i - 8)])
                    end
                    local mX,mY = term.getCursorPos()
                    for i = 1, 19 - mX do
                        write(" ")
                    end
                    write(typeTable[scroll + (i - 8)])
                    local mX,mY = term.getCursorPos()
                    for i = 1, 30 - mX do
                        write(" ")
                    end
                    write(sizeTable[scroll + (i - 8)])
                    local mX,mY = term.getCursorPos()
                    for i = 1, 50 - mX do
                        write(" ")
                    end
                end
                term.setCursorPos(1, 12)
                term.setTextColor(colors.red)
                if string.len(listTable[scroll]) >= 17 then
                    write(">"..string.sub(listTable[scroll], 1, 14).."...")
                else
                    write(">"..listTable[scroll])
                end
                local mX,mY = term.getCursorPos()
                for i = 1, 19 - mX do
                    write(" ")
                end
            end
        end
    drawList(dirTab, listTable, scroll)
        for i = 1, 4 do
            term.setCursorPos(24, 14 + i)
            term.setTextColor(colors.white)
            term.setBackgroundColor(colors.lightGray)
            write(
                i == 1 and syntaxTab.menuNames[synOpt] or
                i == 2 and expiryTab[expOpt] or
                i == 3 and exposureTab[pubOpt] or
                i == 4 and hidden and "[X]" or
                i == 4 and not hidden and "[ ]"
                )
            local mX, mY = term.getCursorPos()
            for i = 1, 50 - mX do
                write(" ")
            end
        end

        local function drawMiniMenu(menuType, menuTable)
            for i = 5, 12 do
                paintutils.drawLine(10, i, 41, i, colors.blue)
                paintutils.drawLine(11, i, 40, i, colors.white)
            end
            for i = 5, 12 do
                term.setCursorPos(38,i)
                term.setTextColor(i == 5 and colors.black or i == 12 and colors.black or colors.lightGray)
                write(i == 5 and "/\\" or i == 12 and "\\/" or "||")
            end
            local menuNum = 0
            local scroll = menuType == "syntax" and 127 or 0
            while true do
                local selected = menuType == "syntax" and menuTable[scroll + 1] or menuTable[scroll + 1]
                if menuType == "syntax" then
                    menuNum = #menuTable
                    for i = 1, 6 do
                        paintutils.drawLine(12, i + 5, 36, i + 5, colors.white)
                        term.setCursorPos(12, i + 5)
                        if selected == menuTable[scroll + i] then
                            term.setBackgroundColor(colors.lightGray)
                        else
                            term.setBackgroundColor(colors.white)
                        end
                        term.setTextColor(colors.blue)
                        write(menuTable[scroll + i])
                    end
                elseif menuType == "expiration" or menuType == "exposure" then
                    menuNum = #menuTable
                    for i = 1, menuNum do
                        term.setCursorPos(12, i + 5)
                        term.setBackgroundColor(colors.white)
                        term.setTextColor(colors.blue)
                        write(menuTable[i])
                    end
                    term.setCursorPos(12, scroll + 6)
                    term.setBackgroundColor(colors.lightGray)
                    write(menuTable[scroll + 1])
                end
                local events = {os.pullEvent()}
                if events[1] == "mouse_scroll" and menuType == "syntax" then
                    if events[2] == 1 then
                        if scroll >= menuNum - 6 then
                            scroll = menuNum - 6
                        else
                            scroll = scroll + 1
                        end
                    elseif events[2] == -1 then
                        if scroll <= 0 then
                            scroll = 0
                        else
                            scroll = scroll - 1
                        end
                    end
                elseif events[1] == "char" then
                    for i = 1, #syntaxTab.menuNames do
                        if string.lower(string.sub(syntaxTab.menuNames[i], 1, 1)) == events[2] then
                            scroll = i
                            break
                        end
                    end
                elseif events[1] == "key" then
                    if events[2] == 208 then
                        scroll = scroll + 1
                    elseif events[2] == 200 then
                        scroll = scroll - 1
                    elseif events[2] == 28 then
                        for i = 1, #menuTable do
                            if selected == menuTable[i] then
                                selectedNum = i
                                break
                            end
                        end
                        for i = 5, 12 do
                            paintutils.drawLine(2, i, 50, i, colors.lightBlue)
                        end
                        return selectedNum
                    end
                elseif events[1] == "mouse_click" and events[2] == 1 then
                    if events[3] >= 37 and events[3] >= 36 and menuType == "syntax" then
                        if events[4] == 5 then
                            scroll = scroll - 5
                            if scroll <= 5 then
                                scroll = 0
                            end
                        elseif events[4] == 12 then
                            scroll = scroll + 5
                            if scroll >= menuNum - 6 then
                                scroll = menuNum - 6
                            end
                        end
                    elseif events[3] >= 12 and events[3] <= 35 then
                        for i = 6, 11 do
                            if events[4] == i then
                                selected = menuTable[scroll + (i - 5)]
                                scroll = i - 6
                            end
                        end
                    end
                end
                if scroll >= menuNum then
                    scroll = menuNum - 1
                elseif scroll < 0 then
                    scroll = 0
                end
            end
        end

        local events = {os.pullEvent()}
        if events[1] == "mouse_scroll" then
            if events[2] == 1 then
                if scroll >= #listTable then
                    scroll = #listTable
                elseif scroll >= 1 and scroll < #listTable then
                    scroll = scroll + 1
                    drawList(dirTab, listTable, scroll)
                end
            elseif events[2] == -1 then
                if scroll <= 1 then
                    scroll = 1
                elseif scroll >= 1 then
                    scroll = scroll - 1
                    drawList(dirTab, listTable, scroll)
                end
            end
        elseif events[1] == "key" then
            if events[2] == 208 then
                if scroll >= #listTable then
                    scroll = #listTable
                elseif scroll >= 1 and scroll < #listTable then
                    scroll = scroll + 1
                    drawList(dirTab, listTable, scroll)
                end
            elseif events[2] == 200 then
                if scroll <= 1 then
                    scroll = 1
                elseif scroll >= 1 then
                    scroll = scroll - 1
                    drawList(dirTab, listTable, scroll)
                end
            elseif events[2] == 28 then
                if scroll == 1 and dir ~= "/" then
                    table.remove(dirTab)
                    scroll = 1
                    for i = 5,13 do
                        paintutils.drawLine(1,i,x,i,colors.lightBlue)
                    end
                else
                    if fs.isDir(table.concat(dirTab, "/").."/"..listTable[scroll]) then
                        table.insert(dirTab, listTable[scroll])
                        scroll = 1
                        for i = 5,13 do
                            paintutils.drawLine(1,i,x,i,colors.lightBlue)
                        end
                    else
                        local fileName = shell.resolve(table.concat(dirTab, "/").."/"..listTable[scroll])
                        local file = fs.open(fileName, "r")
                        local postText = file.readAll()
                        file.close()
                        for i = 7, 12 do
                            paintutils.drawLine(10, i, 41, i, colors.blue)
                            paintutils.drawLine(11, i, 40, i, colors.white)
                            paintutils.drawLine(12, i, 39, i, colors.lightGray)
                        end
                        paintutils.drawLine(13, 10, 38, 10, colors.white)
                        term.setCursorPos(21, 8)
                        term.setTextColor(colors.black)
                        term.setBackgroundColor(colors.lightGray)
                        write("Post name:")
                        term.setCursorPos(14,10)
                        term.setTextColor(colors.black)
                        term.setBackgroundColor(colors.lightGray)
                        local postName = limitRead(25)
                        if logged then
                            --add logged upload
                            local response = http.post(
                                "http://pastebin.com/api/api_post.php", 
                                "api_option=paste&"..
                                "api_dev_key="..devKey.."&"..
                                "api_paste_format="..syntaxTab.urlCodes[synOpt].."&"..
                                "api_user_key="..userKey.."&"..
                                "api_paste_name="..textutils.urlEncode(postName).."&"..
                                "api_paste_private="..(pubOpt - 1).."&"..
                                "api_paste_expire_date="..expTabList[expOpt].."&"..
                                "api_paste_code="..textutils.urlEncode(postText)
                                )
                            if response then
                                local pasteURL = response.readAll()
                                for i = 7, 12 do
                                    paintutils.drawLine(10, i, 41, i, colors.blue)
                                    paintutils.drawLine(11, i, 40, i, colors.white)
                                    paintutils.drawLine(12, i, 39, i, colors.lightGray)
                                end
                                term.setCursorPos(17, 8)
                                term.setTextColor(colors.black)
                                term.setBackgroundColor(colors.lightGray)
                                write("Paste saved at:")
                                term.setCursorPos(12, 10)
                                term.setTextColor(colors.lime)
                                write(pasteURL)
                                os.pullEvent()
                            end
                        else
                            --not logged upload
                            local response = http.post(
                                "http://pastebin.com/api/api_post.php", 
                                "api_option=paste&"..
                                "api_dev_key="..devKey.."&"..
                                "api_paste_format="..syntaxTab.urlCodes[synOpt].."&"..
                                "api_paste_name="..textutils.urlEncode(postName).."&"..
                                "api_paste_expire_date="..expTabList[expOpt].."&"..
                                "api_paste_code="..textutils.urlEncode(postText)
                                )
                            if response then
                                local pasteURL = response.readAll()
                                for i = 7, 12 do
                                    paintutils.drawLine(10, i, 41, i, colors.blue)
                                    paintutils.drawLine(11, i, 40, i, colors.white)
                                    paintutils.drawLine(12, i, 39, i, colors.lightGray)
                                end
                                term.setCursorPos(17, 8)
                                term.setTextColor(colors.black)
                                term.setBackgroundColor(colors.lightGray)
                                write("Paste saved at:")
                                term.setCursorPos(12, 10)
                                term.setTextColor(colors.lime)
                                write(pasteURL)
                                os.pullEvent()
                            end
                        end
                    end
                end
            end
        elseif events[1] == "char" then
            for i = 1, #listTable do
                if string.lower(string.sub(listTable[i], 1, 1)) == events[2] then
                    scroll = i
                    break
                end
                drawList(dirTab, listTable, scroll)
            end
        elseif events[1] == "mouse_click" and events[2] == 1 then
            if events[4] == 15 then
                if events[3] >= 24 and events[3] <= 48 then
                    synOpt = drawMiniMenu("syntax", syntaxTab.menuNames)
                end
            elseif events[4] == 16 then
                if events[3] >= 24 and events[3] <= 48 then
                    expOpt = drawMiniMenu("expiration", expiryTab)
                end
            elseif events[4] == 17 then
                if events[3] >= 24 and events[3] <= 48 then
                    pubOpt = logged and drawMiniMenu("exposure", exposureTab) or 1
                end
            elseif events[4] == 18 then
                if events[3] >= 24 and events[3] <= 26 then
                    if hidden == true then
                        hidden = false
                    elseif hidden == false then
                        hidden = true
                    end
                end
            elseif events[4] == 2 then
                if events[3] >= 1 and events[3] <= 5 then
                    os.queueEvent(unpack(events))
                    break
                elseif events[3] >= 21 and events[3] <= 24 then
                    os.queueEvent(unpack(events))
                    break
                elseif events[3] >= 28 and events[3] <= 31 then
                    os.queueEvent(unpack(events))
                    break
                elseif events[3] >= 34 and events[3] <= 42 then
                    os.queueEvent(unpack(events))
                    break
                elseif events[3] >= 45 and events[3] <= 49 then
                    os.queueEvent(unpack(events))
                    break
                end
            elseif events[4] == 1 and events[3] == x then
                os.queueEvent("terminate")
                break
            end
        end
    end
end

--button objects
buttons = {
    {name = not logged and "Login" or "Welcome!",
    action = function() loginScript() end,
    color = colors.black,
    BGcolor = colors.lightGray,
    x1 = 1,
    x2 = 5,
    y = 2},
    {name = fWolf and "Home" or "",
    action = fWolf and function()
                term.clear = oldTerm
                redirect("home")
            end or
            function()
                if checkCode() then
                    unlock()
                end
            end,
    color = colors.black,
    BGcolor = colors.lightGray,
    x1 = 21,
    x2 = 24,
    y = 2},
    {name = "New",
    action = function() newPaste() end,
    color = colors.black,
    BGcolor = colors.lightGray,
    x1 = 28,
    x2 = 31,
    y = 2},
    {name = "Download",
    action = function() downloadPaste() end,
    color = colors.black,
    BGcolor = colors.lightGray,
    x1 = 34,
    x2 = 42,
    y = 2},
    {name = "Help",
    action = function()
                helpScreen()
            end,
    color = colors.black,
    BGcolor = colors.lightGray,
    x1 = 45,
    x2 = 49,
    y = 2},
    {name = "X",
    action = fWolf and function()
                sleep(0)
            end or
            function()
                os.queueEvent("terminate")
            end,
    color = colors.white,
    BGcolor = colors.red,
    x1 = 51,
    x2 = 51,
    y = 1}
    }

--gui functions
local logoTab = {
" __                      _   ",
"/ _\\_ __ ___   __ _ _ __| |_ ",
"\\ \\| '_ ' _ \\ / _' | '__| __|",
"_\\ \\ | | | | | (_| | |  | |_ ",
"\\__/_| |_| |_|\\__,_|_|   \\__|",
"   ___          _            ",
"  / _ \\__ _ ___| |_ ___      ",
" / /_)/ _' / __| __/ _ \\     ",
"/ ___/ (_| \\__ \\ ||  __/     ",
"\\/    \\__,_|___/\\__\\___|     "}

function background()
    term.setBackgroundColor(colors.black)
    term.setTextColor(colors.white)
    if fWolf then
        os.pullEvent, term = hideBar()
        term.clear()
    else
        term.clear()
    end
    term.setCursorPos(1,1)
    if fWolf then hideBar() end
    term.setTextColor(colors.white)
    term.setBackgroundColor(colors.blue)
    write(logged and "SmartPaste - "..username or "SmartPaste")
    repeat
        local tX, tY = term.getCursorPos()
        write(" ")
    until tX == x - 1
    term.setCursorPos(1,2)
    term.setBackgroundColor(colors.lightGray)
    write(string.rep(" ", x))
    for i = 1, #buttons do
        term.setCursorPos(buttons[i].x1, buttons[i].y)
        term.setBackgroundColor(buttons[i].BGcolor)
        term.setTextColor(buttons[i].color)
        write(buttons[i].name)
        term.setBackgroundColor(colors.black)
    end
    if fWolf then
        term.setCursorPos(25,17)
        term.setTextColor(colors.white)
        write("Firewolf Edition")
    end
    if logged then
        term.setCursorPos(1,2)
        term.setBackgroundColor(colors.lightGray)
        term.setTextColor(colors.black)
        write("Logout")
    end
    paintutils.drawImage(logo, 3, 3)
    for i = 1, #logoTab do
        term.setCursorPos(22, i + 5)
        term.setTextColor(fWolf and colors.orange or colors.blue)
        term.setBackgroundColor(colors.black)
        write(logoTab[i])
    end
end

-- Main menu navigation system
background()
while true do
    local events = {os.pullEventRaw()}
    if events[1] == "mouse_click" and events[2] == 1 and events[4] <= 2 and events[4] >= 1 then
        background()
        for i = 1, #buttons do
            if events[4] == buttons[i].y then
                if events[3] >= buttons[i].x1 and events[3] <= buttons[i].x2 then
                    term.setCursorPos(buttons[i].x1, buttons[i].y)
                    term.setBackgroundColor(colors.red)
                    term.setTextColor(buttons[i].color)
                    write(buttons[i].name)
                    term.setBackgroundColor(colors.black)
                    term.setTextColor(colors.white)
                    buttons[i].action()
                end
            end
        end
    elseif events[1] == "terminate" then
        term.setBackgroundColor(colors.black)
        term.setTextColor(colors.white)
        if fWolf then
            os.pullEvent, term = showBar()
            term.clear()
        else
            term.clear()
        end
        term.setCursorPos(1,1)
        print("Thank you for using SmartPaste!")
        return
    end
end