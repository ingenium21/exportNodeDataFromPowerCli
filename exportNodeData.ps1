[CmdletBinding()]
param (
    [Parameter(Position=0,mandatory=$true)]
    [string]$ViServer, 
)

#initialize the powercli environment
import-module vmware.powercli

connect-viserver $ViServer;

#get all VMs that are turned on
$VMs = get-vm * | ? {$_.PowerState -eq 'PoweredOn'}
$string = ''
if !(test-path C:\users\ms_rregalado\desktop\xmlData.txt){
new-item -type file C:\users\ms_rregalado\desktop\xmlData.txt
}
else {
clear-content C:\users\ms_rregalado\desktop\xmlData.txt
}
foreach ($v in $VMs) {
$String = '<Node Name="GEN1BLMVC01" Type="Connection" Descr="" Icon="Windows" Panel="General" Id="46bc8ae7-ceca-4ea6-926c-4361812c3eda" Username="ms_rregalado" Domain="GENTRYLOCKE" Password="" Hostname="10.151.170.248" Protocol="RDP" PuttySession="Default Settings" Port="3389" ConnectToConsole="false" UseCredSsp="true" RenderingEngine="IE" ICAEncryptionStrength="EncrBasic" RDPAuthenticationLevel="NoAuth" RDPMinutesToIdleTimeout="0" RDPAlertIdleTimeout="false" LoadBalanceInfo="" Colors="Colors16Bit" Resolution="FitToWindow" AutomaticResize="true" DisplayWallpaper="false" DisplayThemes="false" EnableFontSmoothing="false" EnableDesktopComposition="false" CacheBitmaps="false" RedirectDiskDrives="false" RedirectPorts="false" RedirectPrinters="false" RedirectSmartCards="false" RedirectSound="DoNotPlay" SoundQuality="Dynamic" RedirectKeys="false" Connected="false" PreExtApp="" PostExtApp="" MacAddress="" UserField="" ExtApp="" VNCCompression="CompNone" VNCEncoding="EncHextile" VNCAuthMode="AuthVNC" VNCProxyType="ProxyNone" VNCProxyIP="" VNCProxyPort="0" VNCProxyUsername="" VNCProxyPassword="" VNCColors="ColNormal" VNCSmartSizeMode="SmartSAspect" VNCViewOnly="false" RDGatewayUsageMethod="Never" RDGatewayHostname="" RDGatewayUseConnectionCredentials="Yes" RDGatewayUsername="" RDGatewayPassword="" RDGatewayDomain="" InheritCacheBitmaps="false" InheritColors="false" InheritDescription="false" InheritDisplayThemes="false" InheritDisplayWallpaper="false" InheritEnableFontSmoothing="false" InheritEnableDesktopComposition="false" InheritDomain="true" InheritIcon="false" InheritPanel="false" InheritPassword="true" InheritPort="false" InheritProtocol="false" InheritPuttySession="false" InheritRedirectDiskDrives="false" InheritRedirectKeys="false" InheritRedirectPorts="false" InheritRedirectPrinters="false" InheritRedirectSmartCards="false" InheritRedirectSound="false" InheritSoundQuality="false" InheritResolution="false" InheritAutomaticResize="false" InheritUseConsoleSession="false" InheritUseCredSsp="false" InheritRenderingEngine="false" InheritUsername="true" InheritICAEncryptionStrength="false" InheritRDPAuthenticationLevel="false" InheritRDPMinutesToIdleTimeout="false" InheritRDPAlertIdleTimeout="false" InheritLoadBalanceInfo="false" InheritPreExtApp="false" InheritPostExtApp="false" InheritMacAddress="false" InheritUserField="false" InheritExtApp="false" InheritVNCCompression="false" InheritVNCEncoding="false" InheritVNCAuthMode="false" InheritVNCProxyType="false" InheritVNCProxyIP="false" InheritVNCProxyPort="false" InheritVNCProxyUsername="false" InheritVNCProxyPassword="false" InheritVNCColors="false" InheritVNCSmartSizeMode="false" InheritVNCViewOnly="false" InheritRDGatewayUsageMethod="false" InheritRDGatewayHostname="false" InheritRDGatewayUseConnectionCredentials="false" InheritRDGatewayUsername="false" InheritRDGatewayPassword="false" InheritRDGatewayDomain="false" />'
$guest = get-vmGuest -VM $v
$guestName = $guest.Vmname
$guestIP = $guest.IPAddress[0]
write-host $guestName
write-host $guestIP
$NATIP =  $guestIP -replace '192.168.156', '10.151.170'
$String = $String.Replace("GEN1BLMVC01", $guestName)
$String = $String.Replace("10.151.170.248",$NATIP)
$String | out-file C:\users\ms_rregalado\desktop\xmlData.txt -Append
}
