# Avvia da Power Shell andando nel path dove è il file con "cd path" e digitando: PS C:\...\Desktop> powershell -ExecutionPolicy Bypass -File .\click.ps1

Add-Type -AssemblyName PresentationFramework
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class MouseSimulator {
    [DllImport("user32.dll", CharSet = CharSet.Auto, CallingConvention = CallingConvention.StdCall)]
    public static extern void mouse_event(int dwFlags, int dx, int dy, int cButtons, int dwExtraInfo);

    public const int MOUSEEVENTF_LEFTDOWN = 0x02;
    public const int MOUSEEVENTF_LEFTUP = 0x04;

    public static void DoMouseClick() {
        mouse_event(MOUSEEVENTF_LEFTDOWN | MOUSEEVENTF_LEFTUP, 0, 0, 0, 0);
    }
}
"@

# Creazione della finestra GUI
[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Autoclicker" Height="250" Width="400">
    <Grid>
        <Label Content="Numero di Click:" HorizontalAlignment="Left" Margin="10,10,0,0" VerticalAlignment="Top"/>
        <TextBox Name="ClickBox" HorizontalAlignment="Left" Margin="150,10,0,0" VerticalAlignment="Top" Width="200"/>
        <Label Content="Intervallo (ms):" HorizontalAlignment="Left" Margin="10,50,0,0" VerticalAlignment="Top"/>
        <TextBox Name="IntervalBox" HorizontalAlignment="Left" Margin="150,50,0,0" VerticalAlignment="Top" Width="200"/>
        <Button Content="Avvia" HorizontalAlignment="Left" Margin="10,100,0,0" VerticalAlignment="Top" Width="75" Name="StartButton"/>
        <Button Content="Esci" HorizontalAlignment="Left" Margin="100,100,0,0" VerticalAlignment="Top" Width="75" Name="ExitButton"/>
        <Label Name="StatusLabel" Content="" HorizontalAlignment="Left" Margin="10,150,0,0" VerticalAlignment="Top" Width="370"/>
    </Grid>
</Window>
"@

$reader = New-Object System.Xml.XmlNodeReader $xaml
$window = [Windows.Markup.XamlReader]::Load($reader)

# Eventi dei pulsanti
$window.FindName("StartButton").Add_Click({
    $clicks = [int]$window.FindName("ClickBox").Text
    $interval = [int]$window.FindName("IntervalBox").Text

    if ($clicks -gt 0 -and $interval -ge 0) {
        $window.FindName("StatusLabel").Content = "Esecuzione in corso..."
        for ($i = 1; $i -le $clicks; $i++) {
            [MouseSimulator]::DoMouseClick()
            Start-Sleep -Milliseconds $interval
        }
        $window.FindName("StatusLabel").Content = "Click completati!"
    } else {
        $window.FindName("StatusLabel").Content = "Errore: Valori non validi."
    }
})

$window.FindName("ExitButton").Add_Click({
    $window.Close()
})

# Mostra la finestra
$window.ShowDialog()
