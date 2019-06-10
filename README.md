Google Text to Speech (TTS) in VitalPBX
=====

This script makes use of Google's translate text to speech service
in order to render text to speech and play it back to the user.
It supports a variety of different languages.

This TTS service is 'unofficial' and not supported by Google,
it can be terminated at any point with no warning.
People looking for TTS solutions to base their projects/products on
should look for alternative, officially supported  services.

## Requirements<br>
Perl:                    The Perl Programming Language<br>
perl-libwww-perl:        The World-Wide Web library for Perl<br>
perl-LWP-Protocol-https: For HTTPS support<br>
sox:                     Sound eXchange, sound processing program<br>
mpg123:                  MPEG Audio Player and decoder<br>
Internet access in order to contact google and get the voice data.

## Installation<br>
Install dependencies
<pre>
[root@vitalpbx ~]# yum install perl perl-LWP-Protocol-https mpg123 sox perl-libwww-perl
</pre>

Copy googletts.agi to your agi-bin directory.
<pre>
[root@vitalpbx ~]# cd /var/lib/asterisk/agi-bin/
[root@vitalpbx ~]# wget https://github.com/VitalPBX/Google_TTS_VitalPBX/blob/master/googletts.agi
[root@vitalpbx ~]# chown asterisk:asterisk googletts.agi
[root@vitalpbx ~]# chmod +x googletts.agi
</pre>

## Usage<br>
agi(googletts.agi,"text",[language],[intkey],[speed]): This will invoke the Google TTS
engine, render the text string to speech and play it back to the user.
If 'intkey' is set the script will wait for user input. Any given interrupt keys will
cause the playback to immediately terminate and the dialplan to proceed to the
matching extension (this is mainly for use in IVR, see README for examples).
If 'speed' is set the speech rate is altered by that factor (defaults to 1.2).

The script contacts Google's TTS service in order to get the voice data
which then stores in a local cache (by default /tmp/) for future use.
Parameters like default language, enabling or disabling caching and cache dir
can be set up by editing the script.

## Examples<br>
sample dialplan code for your extensions.conf

<pre>
[cos-all](+)
;GoogleTTS Demo
;PLayback messages to user

exten => *887,1,Answer()
  ;;Play mesage in English:
exten => *887,n,agi(googletts.agi,"This is a simple VitalPBX text to speech test in english, powered by Google",en)
  ;;Play message in Spanish:
exten => *887,n,agi(googletts.agi,"Esta es una prueba simple de texto a voz de VitalPBX en español, con tecnología de Google.",es)
  ;;Play message in Greek:
exten => *887,n,agi(googletts.agi,"Αυτό είναι ένα απλό VitalPBX κείμενο σε ομιλία στην ελληνική γλώσσα, powered by Google",el)
  ;;Play message in Japanese:
exten => *887,n,agi(googletts.agi,"これはグーグルによって供給された日本語のスピーチテストへの簡単なVitalPBXテキストです。",ja)
  ;;Play message in simplified Chinese:
exten => *887,n,agi(googletts.agi,"这是一个简单的VitalPBX文本到语音测试，简体中文，由Google提供支持",zh-CN)
exten => *887,n,Hangup()

;A simple dynamic IVR using GoogleTTS

exten => *8870,1,Answer()
exten => *8870,n,Set(TIMEOUT(digit)=5)
exten => *8870,n,agi(googletts.agi,"Welcome to my small interactive voice response menu.",en)
    ;;Wait for digit:
exten => *8870,n(start),agi(googletts.agi,"Please dial a digit.",en,any)
exten => *8870,n,WaitExten()

    ;;PLayback the name of the digit and wait for another one:
exten => _X,1,agi(googletts.agi,"You just pressed ${EXTEN}. Try another one please.",en,any)
exten => _X,n,WaitExten()

exten => i,1,agi(googletts.agi,"Invalid extension.",en)
exten => i,n,goto(s,start)

exten => t,1,agi(googletts.agi,"Request timed out.",en)
exten => t,n,goto(s,start)

exten => h,1,Hangup()
</pre>

## Supported Languages<br>
Afrikaans:          af<br>
Albanian:           sq<br>
Amharic:            am<br>
Arabic:             ar<br>
Armenian:           hy<br>
Azerbaijani:        az<br>
Basque:             eu<br>
Belarusian:         be<br>
Bengali:            bn<br>
Bihari:             bh<br>
Bosnian:            bs<br>
Breton:             br<br>
Bulgarian:          bg<br>
Cambodian:          km<br>
Catalan:            ca<br>
Chinese Simplified: zh-CN<br>
Chinese Traditional:zh-TW<br>
Corsican:           co<br>
Croatian:           hr<br>
Czech:              cs<br>
Danish:             da<br>
Dutch:              nl<br>
English:            en<br>
Esperanto:          eo<br>
Estonian:           et<br>
Faroese:            fo<br>
Filipino:           tl<br>
Finnish:            fi<br>
French:             fr<br>
Frisian:            fy<br>
Galician:           gl<br>
Georgian:           ka<br>
German:             de<br>
Greek:              el<br>
Guarani:            gn<br>
Gujarati:           gu<br>
Hausa:              ha<br>
Hebrew:             iw<br>
Hindi:              hi<br>
Hungarian:          hu<br>
Icelandic:          is<br>
Indonesian:         id<br>
Interlingua:        ia<br>
Irish:              ga<br>
Italian:            it<br>
Japanese:           ja<br>
Javanese:           jw<br>
Kannada:            kn<br>
Kazakh:             kk<br>
Kinyarwanda:        rw<br>
Kirundi:            rn<br>
Korean:             ko<br>
Kurdish:            ku<br>
Kyrgyz:             ky<br>
Laothian:           lo<br>
Latin:              la<br>
Latvian:            lv<br>
Lingala:            ln<br>
Lithuanian:         lt<br>
Macedonian:         mk<br>
Malagasy:           mg<br>
Malay:              ms<br>
Malayalam:          ml<br>
Maltese:            mt<br>
Maori:              mi<br>
Marathi:            mr<br>
Moldavian:          mo<br>
Mongolian:          mn<br>
Montenegrin:        sr-ME<br>
Nepali:             ne<br>
Norwegian:          no<br>
Norwegian Nynorsk:  nn<br>
Occitan:            oc<br>
Oriya:              or<br>
Oromo:              om<br>
Pashto:             ps<br>
Persian:            fa<br>
Polish:             pl<br>
Portuguese:         pt<br>
Portuguese Brazil:  pt-BR<br>
Portuguese Portugal:pt-PT<br>
Punjabi:            pa<br>
Quechua:            qu<br>
Romanian:           ro<br>
Romansh:            rm<br>
Russian:            ru<br>
Scots Gaelic:       gd<br>
Serbian:            sr<br>
Serbo-Croatian:     sh<br>
Sesotho:            st<br>
Shona:              sn<br>
Sindhi:             sd<br>
Sinhalese:          si<br>
Slovak:             sk<br>
Slovenian:          sl<br>
Somali:             so<br>
Spanish:            es<br>
Sundanese:          su<br>
Swahili:            sw<br>
Swedish:            sv<br>
Tajik:              tg<br>
Tamil:              ta<br>
Tatar:              tt<br>
Telugu:             te<br>
Thai:               th<br>
Tigrinya:           ti<br>
Tonga:              to<br>
Turkish:            tr<br>
Turkmen:            tk<br>
Twi:                tw<br>
Uighur:             ug<br>
Ukrainian:          uk<br>
Urdu:               ur<br>
Uzbek:              uz<br>
Vietnamese:         vi<br>
Welsh:              cy<br>
Xhosa:              xh<br>
Yiddish:            yi<br>
Yoruba:             yo<br>
Zulu:               zu<br>

## Security Considerations<br>
This script contacts Google servers in order to get voice data.
The script uses TLS to encrypt all the traffic between your pbx and these servers
so no 3rd party can eavesdrop your communication, but your data will be available
to Google under a not yet defined policy.

## Tiny version<br>
The '-tiny' suffixed scripts use the HTTP::Tiny perl module instead of LWP::UserAgent.
This makes them a lot faster when run in small embedded systems or boards like
the Raspberry pi. They can be used as an in-place replacement of the normal versions
of the TTS scripts and expose the same interface/cli args. To use them just make sure
you have HTTP::Tiny installed.
In debian or ubuntu based distros: 'apt-get install libhttp-tiny-perl'
In distros that don't have it in their repos: 'cpan HTTP::Tiny'
It also requires mp3 format support in sox in order to avoid the use of mpg123.

## License<br>
The GoogleTTS script for asterisk is distributed under the GNU General Public
License v2. See COPYING for details.

## Authors<br>
Lefteris Zafiris (zaf@fastmail.com)

## VitalPBX Integrator<br>
Rodrigo Cuadra (rcuadra@vitalpbx.com)

## Homepage<br>
https://github.com/VitalPBX/Google_TTS_VitalPBX/

