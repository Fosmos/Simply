Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$v = @{}
$variablesPath = Resolve-Path "..\@Resources\Variables.inc"
$raw = Get-Content -Path $variablesPath
foreach ($line in $raw)
{
    if ($line -match "^(\w+)\s??=\s??(.*?);?\n?$")
    {
        Write-Host $matches[1]:  $matches[2]
        $v[$matches[1]] = $matches[2]
    }
}

if ($v["playerName"] -eq "") { $v["playerName"]='Spotify' }
if ($v["playerName"] -eq "Spotify" -AND $v["playerPlugin"] -eq "NowPlaying") { $v["playerName"]="Spotify (Now Playing)" }
$rmPath = (Get-Process "Rainmeter").Path

$assemblies=(
    "System", 
    "System.Runtime.InteropServices",
    "System.Windows.Forms"
)

$psforms = @'
using System;
using System.Runtime.InteropServices;
using System.Windows.Forms;

namespace PSForms
{
    public class ListViewX : ListView
    {
        [DllImport("uxtheme.dll", CharSet = CharSet.Unicode)]
        public extern static int SetWindowTheme(IntPtr hWnd, string pszSubAppName, string pszSubIdList);

        protected override void OnHandleCreated(EventArgs e)
        {
            base.OnHandleCreated(e);
            SetWindowTheme(this.Handle, "explorer", null);
        }
    }

    // [WIP]
    public class NumericUpDownX : NumericUpDown
    {
        [DllImport("uxtheme.dll", CharSet = CharSet.Unicode)]
        public extern static int SetWindowTheme(IntPtr hWnd, string pszSubAppName, string pszSubIdList);

        public NumericUpDownX()
        {
            this.Paint += NumericUpDownX_Paint;
            this.GotFocus += NumericUpDownX_GotFocus;
            this.LostFocus += NumericUpDownX_LostFocus;
        }

        public string Unit { get; set; }

        protected override void OnHandleCreated(EventArgs e)
        {
            base.OnHandleCreated(e);
            SetWindowTheme(this.Handle, "explorer", null);
        }

        private void NumericUpDownX_Paint(object sender, PaintEventArgs e)
        {
            //this.Text = this.Value + Unit;
        }

        private void NumericUpDownX_GotFocus(object sender, EventArgs e)
        {
            //this.Text = this.Value.ToString();
        }

        private void NumericUpDownX_LostFocus(object sender, EventArgs e)
        {
            //this.Text = this.Value + Unit;
        }

        /*
        protected override void UpdateEditText()
        {
            // Append the units to the end of the numeric value
            //this.Text = this.Value + Unit;
        }*/
    }
}
'@

$wppsdef = @'
[DllImport("kernel32.dll", CharSet=CharSet.Unicode, SetLastError=true)]
[return: MarshalAs(UnmanagedType.Bool)]
public static extern bool WritePrivateProfileString(string lpAppName,
    string lpKeyName,
    string lpString,
    string lpFileName);
'@

$wpps = Add-Type -MemberDefinition $wppsdef -Name WinWritePrivateProfileString -Namespace Win32Utils -PassThru
Add-Type -ReferencedAssemblies $assemblies -TypeDefinition $psforms -Language CSharp

# Variables
$defaultFontAlign = 'MiddleLeft'
$colorObjectCount = 4

## Debug Helper
function print($message) { & $rmPath !Log $message }

function ToRMColor([System.Drawing.Color] $color)
{
    $colorR = [int]$color.R
    $colorG = [int]$color.G
    $colorB = [int]$color.B
    $colorA = [int]$color.A
    return "$colorR,$colorG,$colorB,$colorA"
}

function ToSDColor([string] $color)
{
    $colors = $color.Split(',')
    return [System.Drawing.Color]::FromArgb($colors[3], $colors[0], $colors[1], $colors[2])
}


# Window Settings
$form                   = New-Object system.Windows.Forms.Form
$form.Size              = '435, 215'
$form.Text              = $v['Config']
$form.TopMost           = $false
$form.Icon              = [Drawing.Icon]::ExtractAssociatedIcon($rmPath)
$form.AutoSize          = $false
$form.FormBorderStyle   = [System.Windows.Forms.FormBorderStyle]::FixedSingle
$form.ShowInTaskbar     = $false
$form.MinimizeBox       = $false
$form.MaximizeBox       = $false
$form.Font              = 'Arial,8'

### <MediaPlayer> ###
    # MediaPlayer
    $lblPlayer           = New-Object system.Windows.Forms.Label
    $lblPlayer.text      = 'Media Player:'
    $lblPlayer.AutoSize  = $true
    $lblPlayer.Location  = '10, 10'
    $lblPlayer.TextAlign = $defaultFontAlign

    $cbPlayer               = New-Object System.Windows.Forms.ComboBox
    $cbPlayer.Size          = '100, 20'
    $cbPlayer.Location      = '150, 8'
    $cbPlayer.DropDownStyle = 'DropDownList'
    $cbPlayer.Items.AddRange(@('Auto','Spotify','Web','WMP','iTunes'))
    $cbPlayer.SelectedItem  = $v['playerName']

    # Tooltip
    $cbTooltip          = New-Object system.Windows.Forms.CheckBox
    $cbTooltip.Text     = 'Full Song Info Tooltip'
    $cbTooltip.AutoSize = $true
    $cbTooltip.Location = '10, 35'
    $cbTooltip.Checked  = [int]$v['ToolTips']

    # Scale
    $lblImageSize           = New-Object system.Windows.Forms.Label
    $lblImageSize.Text      = 'Image Scale:'
    $lblImageSize.AutoSize  = $true
    $lblImageSize.Location  = '10, 60'
    $lblImageSize.TextAlign = $defaultFontAlign

    $numImageSize               = New-Object PSForms.NumericUpDownX
    $numImageSize.Size          = '100, 20'
    $numImageSize.Location      = '150, 58'
    $numImageSize.DecimalPlaces = 0
    $numImageSize.Minimum       = 10
    $numImageSize.Maximum       = 1000
    $numImageSize.Value         = $v['CoverSize']

    # Info Orientation
    $lblOri           = New-Object system.Windows.Forms.Label
    $lblOri.Text      = 'Orientation:'
    $lblOri.AutoSize  = $true
    $lblOri.Location  = '10, 90'
    $lblOri.TextAlign = $defaultFontAlign

    $cbOri                  = New-Object System.Windows.Forms.ComboBox
    $cbOri.Size             = '100, 20'
    $cbOri.Location         = '150, 88'
    $cbOri.DropDownStyle    = 'DropDownList'
    $cbOri.Items.AddRange(@('Horizontal','Vertical'))
    $cbOri.SelectedItem     = $v['Orientation']

    # Info Direction
    $cbDir          = New-Object system.Windows.Forms.CheckBox
    $cbDir.Text     = 'Invert Direction'
    $cbDir.Location = '10, 110'
    $cbDir.Checked  = [int]$v['Direction']

    # AutoHide
    $cbHide             = New-Object System.Windows.Forms.CheckBox
    $cbHide.Text        = 'Auto-Hide'
    $cbHide.AutoSize    = $true
    $cbHide.Location    = '138, 115'
    $cbHide.Checked     = [int]$v['AutoHide']

    # Corner Radius
    $lblCornerRadius            = New-Object system.Windows.Forms.Label
    $lblCornerRadius.text       = 'Cornder Radius:'
    $lblCornerRadius.AutoSize   = $true
    $lblCornerRadius.Location   = '260, 10'
    $lblCornerRadius.TextAlign  = $defaultFontAlign

    $numCornerRadius                = New-Object PSForms.NumericUpDownX
    $numCornerRadius.Size           = '59, 20'
    $numCornerRadius.Location       = '350, 10'
    $numCornerRadius.DecimalPlaces  = 0
    $numCornerRadius.Minimum        = 0
    $numCornerRadius.Maximum        = 100
    $numCornerRadius.Value          = $v['CornerRadius']
### <MediaPlayer/>

### <Color>
    # Chameleon Colors
    $cbChameleon            = New-Object system.Windows.Forms.CheckBox
    $cbChameleon.Text       = 'Default Colors'
    $cbChameleon.AutoSize   = $true
    $cbChameleon.Location   = '260, 35'
    $cbChameleon.Checked    = [int]$v['DefaultColors']
    $cbChameleon.Add_CheckedChanged({ toggleCustomColors })

    $dpObjectColor               = New-Object System.Windows.Forms.ComboBox
    $dpObjectColor.Size          = '150, 20'
    $dpObjectColor.Location      = '260, 55'
    $dpObjectColor.DropDownStyle = 'DropDownList'
    $dpObjectColor.Enabled        = -NOT $cbChameleon.Checked
    $dpObjectColor.Add_SelectedIndexChanged({ colorObjectDPSelection })
    $dpObjectColor.Items.AddRange(@('Artist','Track','Progress Background', 'Progress Foreground'))
    $dpObjectColor.SelectedIndex = 0

    # Populate the custom color panels
    $colorPanels = [System.Collections.ArrayList]::new()
    for ($i = 0; $i -lt $colorObjectCount; ++$i)
    {
        $btnColor           = New-Object system.Windows.Forms.Panel
        $btnColor.Size      = '150, 20'
        $btnColor.Location  = '260, 105'
        $btnColor.Enabled   = -NOT $cbChameleon.Checked
        $btnColor.Add_Click( { ColorPicker } )

        # Set the appropriate color
        if ($v['Color' + ($i + 1) + 'Chameleon'] -eq 1) { $btnColor.BackColor = ToSDColor '255,255,255,255' }
        else { $btnColor.BackColor = ToSDColor $v['Color' + ($i + 1)] }

        # Set all but the first panel to invisible
        if ($i -ne 0) { $btnColor.visible = $false }

        $colorPanels.Add($btnColor)
    }

    # Color Label
    $lblColor           = New-Object system.Windows.Forms.Label
    $lblColor.Text      = 'Color:'
    $lblColor.Size      = '35, 20'
    $lblColor.Location  = '260, 105'
    $lblColor.TextAlign = 'MiddleLeft'
    $lblColor.Enabled   = -NOT $cbChameleon.Checked

    # Possible Chameleon options
    $colorOptions = @(
        '[MeasureCoverFG1]',
        '[MeasureCoverFG2]',
        '[MeasureCoverBG1]',
        '[MeasureCoverBG2]',
        '[MeasureCoverAvrg]',
        '[MeasureDesktopFG1]',
        '[MeasureDesktopFG2]',
        '[MeasureDesktopBG1]',
        '[MeasureDesktopBG2]',
        '[MeasureDesktopAvrg]',
        'Custom'
    )

    $dpsColorOptions = [System.Collections.ArrayList]::new()
    for ($i = 0; $i -lt $colorObjectCount; ++$i)
    {
        # Dropdown for color options
        $dpColorOptions               = New-Object System.Windows.Forms.ComboBox
        $dpColorOptions.Size          = '150, 20'
        $dpColorOptions.Location      = '260, 80'
        $dpColorOptions.DropDownStyle = 'DropDownList'
        $dpColorOptions.Enabled       = -NOT $cbChameleon.Checked
        $dpColorOptions.Add_SelectedIndexChanged({ colorDPSelection })
        $dpColorOptions.Items.AddRange(@(
            'Cover Foreground',
            'Cover Foreground 2',
            'Cover Background',
            'Cover Background 2',
            'Cover Average'
            'Desktop Foreground',
            'Desktop Foreground 2',
            'Desktop Background',
            'Desktop Background 2',
            'Desktop Average'
            'Custom'
        ))

        # Default to custom color
        $dpColorOptions.SelectedItem = 'Custom'

        if ($v['Color'+($i+1)+'Chameleon'] -eq 1)
        {
            # Set the correct chameleon type
            $dpColorOptions.SelectedIndex = [array]::IndexOf($colorOptions, $v['Color' + ($i+1)])
            $colorPanels[$i].Visible      = $false

            if ($i -eq 0) { $lblColor.Visible = $false }
        }

        if ($i -ne 0) { $dpColorOptions.Visible = $false }

        $dpsColorOptions.Add($dpColorOptions)
    }

    function ColorDPSelection
    {
        # Default is visible
        $isVisible = $true

        # If something other then custom is selected then hide the custom colors
        if (-NOT $dpsColorOptions[$dpObjectColor.SelectedIndex].SelectedItem.Equals('Custom')) {
            $isVisible = $false
        }

        # Set the state
        $lblColor.Visible = $isVisible
        $colorPanels[$dpObjectColor.SelectedIndex].Visible = $isVisible
    }

    # Color picker window
    $colorPicker              = New-Object System.Windows.Forms.ColorDialog
    $colorPicker.CustomColors = $true
    $colorPicker.FullOpen     = $true
    function ColorPicker
    {
        # Open the color picker and wait for it to close
        if ($colorPicker.ShowDialog() -eq 1) {
            # Save the new color in the correct panel
            $colorPanels[$dpObjectColor.SelectedIndex].BackColor = $colorPicker.Color
        }
    }

    function ColorObjectDPSelection
    {
        # Loop through every color panel
        for ($i = 0; $i -lt $colorPanels.Count; ++$i)
        {
            # Disable all other color panels
            $colorPanels[$i].Visible     = $false
            $dpsColorOptions[$i].Visible = $false

            if ($dpObjectColor.SelectedIndex -eq $i)
            {
                # Enable the current color option dropdown
                $dpsColorOptions[$i].Visible = $true

                # Enable/Disable the color panel and label
                ColorDPSelection
            }
        }
    }

    function ToggleCustomColors
    {
        # Get the default colors checked status
        $val = -NOT $cbChameleon.Checked

        # Enable/disable user defined color UI elements accordingly
        $dpObjectColor.Enabled = $val
        $lblColor.Enabled      = $val
        foreach ($btnColor in $colorPanels)           { $btnColor.Enabled = $val }
        foreach ($dpColorOptions in $dpsColorOptions) { $dpColorOptions.Enabled = $val }
    }
### <Color/>

# Apply Button
$btnApply           = New-Object system.Windows.Forms.Button
$btnApply.Text      = 'Apply'
$btnApply.Size      = [string]($form.Width - 35) + ', 30'
$btnApply.Location  = '10, ' + [string]($form.Height - 75)
$btnApply.Add_Click({ ApplyClick })

### <Helper Functions> ###
    function WriteKeyValue([string] $key, [string] $value) {
        $wpps::WritePrivateProfileString('Variables', $key, $value, $variablesPath)
    }

    function MediaPlayer
    {
        # Since there are 2 Spotify options set it as the default
        WriteKeyValue playerName 'Auto'
        WriteKeyValue playerPlugin 'WindowsNowPlaying'
        WriteKeyValue playerEXE '%userprofile%\AppData\Roaming\Spotify\Spotify.exe'
        WriteKeyValue ImageName 'spotify.png'
        WriteKeyValye likeVal 'SetRating 5'
        WriteKeyValue noLikeVal "SetRating 0"
        WriteKeyValue heartTint 1DB954

        if ($cbPlayer.SelectedItem.Equals('Spotify'))
        {
            # This is the WebNowPlaying version of Spotify
            WriteKeyValue playerName 'Spotify'
            WriteKeyValue playerPlugin 'Web'
        }
        elseif ($cbPlayer.SelectedItem.Equals('Web'))
        {
            WriteKeyValue playerName 'Web'
            WriteKeyValue playerPlugin 'Web'
            WriteKeyValue playerEXE ''
            WriteKeyValue ImageName 'Web.png'
            WriteKeyValue heartTint 2870B8
        }
        elseif ($cbPlayer.SelectedItem.Equals('WMP'))
        {
            WriteKeyValue playerName 'WMP'
            WriteKeyValue playerEXE 'wmplayer.exe'
            WriteKeyValue ImageName 'WMP.png'
            WriteKeyValue heartTint 2870B8
        }
        elseif ($cbPlayer.SelectedItem.Equals('iTunes'))
        {
            WriteKeyValue playerName 'iTunes'
            WriteKeyValue playerEXE 'iTunes.exe'
            WriteKeyValue ImageName 'itunes.png'
            WriteKeyValue heartTint D3D3D3
        }
    }

    function ApplyColors
    {
        # Default color theme
        $defaultColors = @(
            '255,255,255,255',
            '255,255,255,255',
            '[MeasureCoverBG2]',
            '[MeasureCoverFG2]'
        )
        $defaultChmlns = @(0, 0, 1, 1)

        # Loop through each colorable meter
        for ($i = 0; $i -lt $colorObjectCount; ++$i)
        {
            # Set the defaults
            $color = $defaultColors[$i]
            $chmln = $defaultChmlns[$i]

            # If the Default Colors is checked then override default colors
            if (-NOT $cbChameleon.Checked)
            {
                # If color option not Custom, then it's a chameleon color
                if (-NOT $dpsColorOptions[$i].SelectedItem.Equals('Custom'))
                {
                    # Set the color and chameleon flag
                    $color = $colorOptions[$dpsColorOptions[$i].SelectedIndex]
                    $chmln = 1
                }
                # Custom color
                else
                {
                    $color = ToRMColor $colorPanels[$i].BackColor
                    $chmln = 0
                }
            }

            WriteKeyValue ('Color'+($i+1)) $color
            WriteKeyValue ('Color'+($i+1)+'Chameleon') $chmln
        }
    }

    function ApplyClick
    {
        WriteKeyValue DefaultColors ([int]$cbChameleon.Checked)
        WriteKeyValue ToolTips ([int]$cbTooltip.Checked)
        WriteKeyValue Direction ([int]$cbDir.Checked)
        WriteKeyValue CoverSize $numImageSize.Value
        WriteKeyValue AutoHide ([int]$cbHide.Checked)
        WriteKeyValue CornerRadius $numCornerRadius.Value

        # Set the tooltips
        if ($cbTooltip.Checked)
        {
            WriteKeyValue ArtistToolTip "[MeasureArtistFull]"
            WriteKeyValue TrackToolTip "[MeasureTrackFull]"
        }
        else
        {
            WriteKeyValue ArtistToolTip ""
            WriteKeyValue TrackToolTip ""
        }

        # Set the media player data
        MediaPlayer

        # Set the direction
        WriteKeyValue Orientation $cbOri.SelectedItem
        if ($cbOri.SelectedItem.Equals('Vertical'))
        {
            WriteKeyValue Justify 'Center'
            WriteKeyValue Origin '(#Width#*0.5)'
            WriteKeyValue CoverOrigin '(#Origin#-#CoverSize#*0.5)'

            if ($cbHide.Checked) {
                WriteKeyValue Height '(#CoverSize#)'
            } else {
                WriteKeyValue Height '(#CoverSize#*2)'
            }
        }
        else
        {
            if ($cbDir.Checked)
            {
                WriteKeyValue Justify 'Right'
                WriteKeyValue Origin '(#CoverSize#*6)'
            }
            else
            {
                WriteKeyValue Justify 'Left'
                WriteKeyValue Origin 0
            }

            WriteKeyValue CoverOrigin '#Origin#'
            WriteKeyValue Height '(#CoverSize#)'
        }

        # Set the colors
        ApplyColors

        # Refresh the skin
        & $rmPath !Refresh 'Simply'
    }
### <HelperFunctions/> ###

[System.Collections.ArrayList] $UIElements = @(
    $lblPlayer,
    $cbPlayer,
    $cbTooltip,
    $cbChameleon,
    $lblColor,
    $dpObjectColor,
    $lblOri,
    $cbOri,
    $lblImageSize,
    $numImageSize,
    $cbDir,
    $cbHide,
    $btnApply,
    $lblCornerRadius,
    $numCornerRadius
)

foreach ($dummy in $colorPanels)     { $UIElements.Add($dummy) }
foreach ($dummy in $dpsColorOptions) { $UIElements.Add($dummy) }

$form.controls.AddRange($UIElements)
$form.ResumeLayout()

[Windows.Forms.Application]::Run($form)