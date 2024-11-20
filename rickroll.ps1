[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$ProgressPreference = 'SilentlyContinue'

# 設定下載的 MP4 檔案 URL 和儲存路徑
$videoURL = "https://github.com/ShatteredDisk/rickroll/raw/refs/heads/master/rickroll.mp4"
$savePath = "$env:USERPROFILE\rickroll.mp4"

# 下載 MP4 文件
Write-Host "Downloading video..."
Invoke-WebRequest -Uri $videoURL -OutFile $savePath

Write-Host "Video downloaded to $savePath"

# 啟動並播放視頻（使用預設媒體播放器）
Write-Host "Launching default media player..."
Start-Process "$savePath"

# 等待播放器啟動
Start-Sleep -Seconds 3  # Adjust this based on video length or speed of app opening

# 模擬 F11 按鍵來啟動全螢幕
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class SendKeys {
    [DllImport("user32.dll")]
    public static extern short GetAsyncKeyState(int vKey);
    [DllImport("user32.dll")]
    public static extern int SetForegroundWindow(IntPtr hwnd);
    [DllImport("user32.dll")]
    public static extern int keybd_event(byte bVk, byte bScan, uint dwFlags, uint dwExtraInfo);

    public const int VK_F11 = 0x7A; // F11 key
    public const uint KEYEVENTF_KEYUP = 0x02;

    public static void SendF11()
    {
        keybd_event((byte)VK_F11, 0, 0, 0);  // Key down
        keybd_event((byte)VK_F11, 0, KEYEVENTF_KEYUP, 0);  // Key up
    }
}
"@

# 模擬按下 F11 來開啟全螢幕
[SendKeys]::SendF11()

Write-Host "Video should now be playing in fullscreen."
