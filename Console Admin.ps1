<#
#################################################
# 2020-12-23 - S.I
# the base script comes from : https://www.powershellgallery.com/packages/pcdiag/2.0 ()
# Free to use as you want
#################################################
#>

#region Constructor

[void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")

#endregion



#################################################
# CONFIGURATION DE LA WINDOWS FORM
#################################################

#region Form Creation
#~~< Page d'accueil >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$MainMenu = New-Object System.Windows.Forms.Form
$MainMenu.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog
$MainMenu.MaximizeBox = $False
$MainMenu.MinimizeBox = $False
$MainMenu.Location = New-Object System.Drawing.Point(0, 0)
$MainMenu.Text = "Console Admin - S.I"
$MainMenu.Size = New-Object System.Drawing.Size(870, 375)

#################################################
# AJOUT DES COMPOSANTS
#################################################

#~~< Log Console >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$Log_Console = New-Object System.Windows.Forms.Label
$Log_Console.Font = New-Object System.Drawing.Font("Lucida Console", 9.75, [System.Drawing.FontStyle]::Bold, [System.Drawing.GraphicsUnit]::Point, ([System.Byte](0)))
$Log_Console.Location = New-Object System.Drawing.Point(4, 200)
$Log_Console.Size = New-Object System.Drawing.Size(100, 24)
$Log_Console.TabIndex = 9
$Log_Console.Text = "Log Console"
$Log_Console.TextAlign = [System.Drawing.ContentAlignment]::BottomLeft


#~~< Boite de retour des commandes >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$Outputbox = New-Object System.Windows.Forms.RichTextBox
$Outputbox.Location = New-Object System.Drawing.Point(4, 230)
$Outputbox.Size = New-Object System.Drawing.Size(500, 100)
$Outputbox.Text = ""
$Outputbox.BackColor = [System.Drawing.SystemColors]::Window


#~~< Panneau Bouton Rapide >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$TabControl1 = New-Object System.Windows.Forms.TabControl
$TabControl1.Location = New-Object System.Drawing.Point(0, 110)
$TabControl1.Size = New-Object System.Drawing.Size(690, 90)
$TabControl1.SizeMode = [System.Windows.Forms.TabSizeMode]::FillToRight
$TabControl1.TabIndex = 0
$TabControl1.Text = ""


#~~< Accès Rapide >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$AccesRapide = New-Object System.Windows.Forms.TabPage
$AccesRapide.AutoScroll = $true
$AccesRapide.Location = New-Object System.Drawing.Point(4, 0)
$AccesRapide.Padding = New-Object System.Windows.Forms.Padding(3)
$AccesRapide.Size = New-Object System.Drawing.Size(1153, 155)
$AccesRapide.TabIndex = 0
$AccesRapide.Text = "Accès Rapide"
$AccesRapide.UseVisualStyleBackColor = $true


#~~< Vide du Cache DNS >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$MO_FlushDNS = New-Object System.Windows.Forms.Button
$MO_FlushDNS.Location = New-Object System.Drawing.Point(5, 16)
$MO_FlushDNS.Size = New-Object System.Drawing.Size(95, 33)
$MO_FlushDNS.TabIndex = 1
$MO_FlushDNS.Text = "Vide du Cache DNS"
$MO_FlushDNS.UseVisualStyleBackColor = $true
$MO_FlushDNS.add_Click({MO_FlushDNS_Click($MO_FlushDNS)})


#~~< Nettoyage du Cache ARP >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$MO_ClearARPCache = New-Object System.Windows.Forms.Button
$MO_ClearARPCache.Location = New-Object System.Drawing.Point(105, 16)
$MO_ClearARPCache.Size = New-Object System.Drawing.Size(95, 33)
$MO_ClearARPCache.TabIndex = 2
$MO_ClearARPCache.Text = "Nettoyage du Cache ARP"
$MO_ClearARPCache.UseVisualStyleBackColor = $true
$MO_ClearARPCache.add_Click({MO_ClearARPCache_Click($MO_ClearARPCache)})


#~~< Menu SON >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$MO_SON = New-Object System.Windows.Forms.Button
$MO_SON.Location = New-Object System.Drawing.Point(205, 16)
$MO_SON.Size = New-Object System.Drawing.Size(95, 33)
$MO_SON.TabIndex = 3
$MO_SON.Text = "Menu Son"
$MO_SON.UseVisualStyleBackColor = $true
$MO_SON.add_Click({MO_SON_Click($MO_SON)})


#~~< Menu Programme >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$MO_PROG = New-Object System.Windows.Forms.Button
$MO_PROG.Location = New-Object System.Drawing.Point(305, 16)
$MO_PROG.Size = New-Object System.Drawing.Size(95, 33)
$MO_PROG.TabIndex = 4
$MO_PROG.Text = "Menu Programme"
$MO_PROG.UseVisualStyleBackColor = $true
$MO_PROG.add_Click({MO_PROG_Click($MO_PROG)})


#~~< Menu Pare-Feu Windows Defender >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$MO_FW = New-Object System.Windows.Forms.Button
$MO_FW.Location = New-Object System.Drawing.Point(405, 16)
$MO_FW.Size = New-Object System.Drawing.Size(95, 33)
$MO_FW.TabIndex = 5
$MO_FW.Text = "Menu Pare-Feu"
$MO_FW.UseVisualStyleBackColor = $true
$MO_FW.add_Click({MO_FW_Click($MO_FW)})


#~~< Panneau des accès >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$Panel1 = New-Object System.Windows.Forms.Panel
$Panel1.Location = New-Object System.Drawing.Point(0, 5)
$Panel1.Size = New-Object System.Drawing.Size(1100, 113)
$Panel1.TabIndex = 1
$Panel1.Text = ""


#~~< Architecture variable >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$OSVER = if($env:PROCESSOR_ARCHITECTURE -eq "x86"){"32-Bits"}Else{"64-Bits"}
$Info1 = New-Object System.Windows.Forms.Label
$Info1.Location = New-Object System.Drawing.Point(700, 70)
$Info1.Size = New-Object System.Drawing.Size(158, 23)
$Info1.TabIndex = 13
$Info1.Text = "Architecture = $OSVER"


#~~< Version de Windows >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$OS = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion").ReleaseId
$Info2 = New-Object System.Windows.Forms.Label
$Info2.Location = New-Object System.Drawing.Point(700, 50)
$Info2.Size = New-Object System.Drawing.Size(150, 23)
$Info2.TabIndex = 12
$Info2.Text = "Windows version = $OS "


#~~< Nom du poste >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ComputerName = [system.environment]::MachineName 
$ComputerNameBox = New-Object System.Windows.Forms.Button
$ComputerNameBox.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$ComputerNameBox.Location = New-Object System.Drawing.Point(695, 0)
$ComputerNameBox.Size = New-Object System.Drawing.Size(150, 40)
$ComputerNameBox.TabIndex = 1
$ComputerNameBox.Text = "$Computername"
$ComputerNameBox.UseVisualStyleBackColor = $false
$ComputerNameBox.BackColor = [System.Drawing.SystemColors]::Info


#################################################
# PANNEAU DES ACCES / ICONE
#################################################


#~~< Gestion Ordinateur >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ComputerMGMT = New-Object System.Windows.Forms.Button
$ComputerMGMT.Location = New-Object System.Drawing.Point(97, 0)
$ComputerMGMT.Size = New-Object System.Drawing.Size(79, 93)
$ComputerMGMT.TabIndex = 11
$ComputerMGMT.Text = "Gestion Ordinateur"
$ComputerMGMT.TextAlign = [System.Drawing.ContentAlignment]::BottomCenter
$ComputerMGMT.UseVisualStyleBackColor = $true
# Icone de Gestion de l'ordinateur
$ComputerMGMT.Image = ([System.Drawing.Image]([System.Drawing.Image]::FromStream((New-Object System.IO.MemoryStream(($$ = [System.Convert]::FromBase64String(
"iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAABGdBTUEAALGPC/xhBQAAAAlwSFlz"+
                                 "AAAOwQAADsEBuJFr7QAABeBJREFUWEftl3lQ1GUYx50a+6c/smZqnJqMScksURAMFFFAQDTQ5Sid"+
                                 "LKPyqHEKNBCzmhGVARdwOZTlvu9dWE65WTlkuZdzuUVEZNKKsZn+/vY8v93VrZYGTfmj6Zn5zu8Y"+
                                 "9v183ud9f+8My/6vxdb03E8+3UPjZ1vUg+a6V0tbDq5uyqCEfGTLFOgcGJlq6R2WLKmMs7uHcncN"+
                                 "ICr9FaKoapxPLFhaGVcS2FcPeDZoI6J7j9JfsDeyCmfj85BVUPR0ZVjAi8AHrgH7Kd46Cbc6gDuz"+
                                 "u+hn7AqrwA+xOcjIK3zyMizwgVIrwOF77sReEni/FnCtBpyqAPtKSsE97Agpw+mYTKTnyp6MDO8B"+
                                 "nvWHBOYO6AUMu+BCEo4kseMqYFsB2JRTcu7C5nwx/CPTkZZT8ECmVqW21w29uHJ2FwlLwGCON4Wf"+
                                 "WcCdBPZQF3YZdGE7SWwlAesywKoUWK8ATFPmsO6MDN9ciEJ5XRN0Qy+unN1ESp4xQ7kTfNV3gAWE"+
                                 "ZaAuOBt0YRt14T0SeLsIeFMGrJZrs94/DZnykkcTcNrtrvQgmF6Cw8/7CK7fB/pl2KkT2FAMrCGg"+
                                 "aSHwli5rKRsCHkPAgQREBBIkKHzVC+g7wALOBN+smzXD+MpZR3lHF/PHE3BTMkz4/nXhe0GA4Cxg"+
                                 "R7N+l9ZaD+N7Dq8/x4zCXdl0ahECavpk0jNzz3786ec+UqnUxGLzFuXWCCWcs6cEKHdD335H2nQb"+
                                 "aWBDkBk9M4zfc8w5JYAFxfKfBNTqYRN134Df7dk780HnLsDMbAPWmJryH2PFiy/h1ddexwur7WER"+
                                 "kAqHwnlhkzFIDzMEcTYxkENfAn8NnM2BRgSmpmZFY2MTao1mDAMDGqjaOuDz2RdYteoNvPzKSlha"+
                                 "WcH3xEn4njwFt33eMDO3xPLlz2HlAckDkAAzBOnCkvw5cmz4etqIwMDg6Pz4+C1M3riNiclb6Osb"+
                                 "Qltbl5Dm5lZ0dfeiR92PbrqmpmXA2tqGZPxxKDgTLvJ7D0B6GIM4W+gs4PCZYMvhA8qYQH39dbS0"+
                                 "dKK0rBLiMAl6egZxg2UmpjEyMokhzSgGB4fR3z8ElaoTI6NjiLkixbcBgZBERiO/ugUnrk7Dtex3"+
                                 "LYxAfA5w7HThw4k/z63fGRGoqKiFQlGBi+Jw+PufQlRULLp7hqDRTFJHZoTOjE/cJJkJDA2NUkfU"+
                                 "+Or417gkiUJzSytuTt+CurcPxaXlCE4ugkNIKbbnzsGegBwH2qgc3rDbzhgRqKlpQl1dM05yWw/5"+
                                 "IDhYjNraZiiVKrS2dqOtvReK4go0NalIZoa6MYrp6Rncv/8bBgY1KKuoQm6+HDl5MmTnFiA0XAJn"+
                                 "d09Yex2GXZAMjnlzwhnBsVtIgHPw4Cfw8vTCuaBgVFY2oKSkSniflZWP0NAwHD58jGY6jNk7dzEz"+
                                 "Mwt5UcmfwJnZeYhLSIaqvQsR8WkorKyf//582NQud+95G5KxPyeD3fHQhQWOHPkSOx2dkJGeJzw3"+
                                 "NFwXRBIT07B//0fw9PASOjU2NoWa2gaCa8HpmTkETkJsXAKSUtLQqOrC1cZ2XFdr0NKjgbKjH/Kq"+
                                 "a0or2x1+ltvs1ZmykikdWlt6gYUilSbh6NFjcHFypqVpRHt7D82+GAmJKcKM4xOTkZqeheTUdCQm"+
                                 "p6K2uR2t1ClV3yg6h28iIVuOYycCFTrc38sY1DBSaTJcXffAysJSeO7o6EV2Tp4wcy04g8Bpgkhs"+
                                 "XCIuXIyAmDayX+CP87YOLqnrNlqKdCjjRYOmVlU1zRtC/5psmoVcXi7c8+bMyMpBCp0JWnAKpPGJ"+
                                 "uBwbh6iYWERERDnohn60IgkRAVINwQuF1/ohOB7Rl2MhiYpB+KVIBAQEuNFwz1OeFQZ+1FIqlSuq"+
                                 "qxt9amquKYzBOdL4JFyRMliKyOjLiKAzQRx+CSFiscLX13ctDfOMdrR/WQ9lGtWGAnwS6sFh4RHq"+
                                 "UHGEX0hIiInuZ0+nKiuVJiTixzLhkdFT1G6JWCxZuv+Q/mO1bNkfCv5UeJjKNEoAAAAASUVORK5C"+
                                 "YII=")),0,$$.Length)))))
#endregion
$ComputerMGMT.add_Click({ComputerMGMT_Click($ComputerMGMT)})


#~~< Microsoft Management Console >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$MMC = New-Object System.Windows.Forms.Button
$MMC.Location = New-Object System.Drawing.Point(182, 0)
$MMC.Size = New-Object System.Drawing.Size(79, 93)
$MMC.TabIndex = 10
$MMC.Text = "MMC"
$MMC.TextAlign = [System.Drawing.ContentAlignment]::BottomCenter
$MMC.UseVisualStyleBackColor = $true
# Icone du Microsoft Management Console
$MMC.Image = ([System.Drawing.Image]([System.Drawing.Image]::FromStream((New-Object System.IO.MemoryStream(($$ = [System.Convert]::FromBase64String(
"iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAABGdBTUEAALGPC/xhBQAAAAlwSFlz"+
                                 "AAAOwQAADsEBuJFr7QAABr5JREFUWEfNl3lQlHUYx+kAYVkOk1POhQX2YBfYA1gOFc+OyZrU1KbG"+
                                 "HMfGtNIazbCayQYMs5qpP0qNvIi8EEKBZXc5dhdcrmXBCwHDI5PUThWPEcdvz+/dXcVmC8lsemY+"+
                                 "83vf9/fu+3x+z/u877zrtnbdZ++szivA/SRvzYer3dzcPIgHiTsj/4O1N7uP9+PA0RPE8XtiUe6n"+
                                 "LkcmQamCCCZxZxR8+Aley72/OARiCW8u6dDIW7MOvSf675ruvh/Qdew0DnWfvGscAvGED5d0aND9"+
                                 "wcatu+4rfyvwfl7BlZs3b8IVx78/y5XQ1dxI+H8LsMkbN25gV8meO2DH+r7/kRNg2/fCsAKDg4Mu"+
                                 "cQq4mhsJwwpcv36dw7l6537fKbuAc/+fMqzAtWvXXPLdqX5OwNXcSLhrgaE9wPb/M4GrV6+6xCng"+
                                 "am4kDCtw5coVDufq2fbAzz+hu86MvMWr8Ft3NwbOnuWOW1tbMWnSJLjz+RBJJFi8ZAmKiorQ09Nz"+
                                 "6zp/ZliBy5cv2xkYwM+dNpws3IBDC+fDOnUiWrM06HzqSfSsfBP1774NWVgYcufMwb4dO/BRfj5m"+
                                 "z5iBADqWkZ2N3t7e29cawl0JlO3YCcvy12F9dApaU1VoUSShTa2AjWhSJmPjt6XIzEhHQXQkjj82"+
                                 "FYfnPY8j+Xno3V6MLq0WS5+bi5dI7OKZMyMXGKCVn9Nr8bu1DReam3C+dA9OfbwOPa8uweGnp8M6"+
                                 "PhOfqRRYL07AznQ1bER7Rho6qTqHsjNwmipVkqnBU0oFDr7/HvTLXkPHhi9wpKoS/R0dyF+dN7yA"+
                                 "dfo0HJ47B31v56K/cCN+1etwobUFv5PQL9VanN+wHidXvYXO52ajfcpEtJBEC1WnLU2FTpKpV6Vg"+
                                 "0Zxnsc2gw6bZs3AoMx02omN8FhqpYvrxWVV7JaJ8R9rbwQQuXboEvTweFYKxqBZGolYshEUmRteE"+
                                 "LHQveBEnaFX9mwrxU1kpx5mtm9FXsAaHX1kM28xn0DY5B00kwarjrJKVkrdThSy0bUiUoCpWALNc"+
                                 "jiqBYKYjtT2cAo3T0tEwVYVajRRaSv51djp2U+ktiWLUi4RoSpbBRuU+MP0JdM17AT1U5u9yV+LY"+
                                 "yhU4ym7V/HnomTUDXdRDtpzxsE7IhFmTihpJEkpDgmFISIBFoUaDSn3dkdoe7HvtndX5Vy3ZKrRN"+
                                 "0KBlchqaUpJQuHULXl24ABVJCdDJYlEpjEBFTBh08dEwJibQOTK00eoO0C04Mi4TB554HAeffpKY"+
                                 "joMk6Uy+K2AMKqOjUS+TwZgkQ5U8ifXDA8TDjpH7Tgvan54Ca0YGNVgqJ9DWYeMEjFlK7J+s4qpj"+
                                 "nqJETZoY1bIYEgqHUSZBcbYGJTnj0ExN2p6q5qTaqVKMIh8flIcz6ThUJ8RBJxVib1wCE2A5vQgm"+
                                 "wX2pejQoZGglayutaGgFGqmz29VKajY1WjPVsOSo0TiZSklChsS4W+eVS2JvVchEt9CikNPqH0FJ"+
                                 "UAAq6ZhBJYEpS+UU8CX8CE/CHuZEEZqpq1vomWcCn69Yhk+os1uogZroncBopuPNyWxMRiudxwSc"+
                                 "ldJqEmGamAKDWgStOBoVsWEoCQ5AdVIc6jTJMKnVMCWlOQUCiRBiNMvNhYlKZEmWwyJPRJNcCqNU"+
                                 "zMG298v+BJOSSu6oQA2V2aKQojEzGQ0TldztKosMhYGal/VCnUxFfZDqFBAQQiKS5ebCKIxBIyVs"+
                                 "EIuIBOwnGkXxMIvj0UBjgygOZpI0O8d4IUzE+uVLuUoZoyJhjouFWUiweeIbby9Ux0lJQEECatQm"+
                                 "qp0CKYSKYJ/q9tALIptrBFE3TCTCLmLiiAETM8YICOpkJwJGFIz0WtZFhEIXFcFt1zkwxtAcwQR0"+
                                 "IjkMJFAjpZ6R3BLIIqQEa0R77AwP9yrm8ZR7/H1X7Q0MKK8MCe7UhoUO1EaEoy6SoLE2Igw14WNR"+
                                 "E2bHQNSODeUwEDVjQ2gMQS2dw0a7APWKRAm9WI16aTrKIkTnKF04wT0Bfxmb/fz8d/v4ZOzk8ZaX"+
                                 "+ft+tXf0aFtlYMCgPigI+qBA6IMDoaNRFxhwG3rmGXrqfDbaBRQwSNPoMVSiPDiidL23t8yRYmSx"+
                                 "mR6ZInd3BQmtKOV7by3j8637+PyLVf5+0Pr7c1T5+doZ7ceNTMAgScW+aPHpYr7/y1R77sXzr8Q2"+
                                 "+p9X7OmpKfbweGOHp2dhyahR1jKe12AFj4dKvje+5XuhNDQKJSGR27/08BA7fnZ/Yhe9yIp4vNAt"+
                                 "Dz302HZ39zW7Rz1cvttvTFOx7yOrNri58RynuQg3tz8AaBOp6q4LeS0AAAAASUVORK5CYII=")),0,$$.Length)))))
#endregion
$MMC.add_Click({MMC_Click($MMC)})


#~~< Redémarrage de l'ordinateur >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$RestartComputer = New-Object System.Windows.Forms.Button
$RestartComputer.Location = New-Object System.Drawing.Point(12, 0)
$RestartComputer.Size = New-Object System.Drawing.Size(79, 93)
$RestartComputer.TabIndex = 9
$RestartComputer.Text = "Redémarrer"
$RestartComputer.TextAlign = [System.Drawing.ContentAlignment]::BottomCenter
$RestartComputer.UseVisualStyleBackColor = $true
# Icone du Rédémarrage du l'ordinateur
$RestartComputer.Image = ([System.Drawing.Image]([System.Drawing.Image]::FromStream((New-Object System.IO.MemoryStream(($$ = [System.Convert]::FromBase64String(
"iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAABGdBTUEAALGPC/xhBQAAAAlwSFlz"+
                                 "AAAOwQAADsEBuJFr7QAACl5JREFUWEe9l3lY1VUax3EJFyRJSFRc2Bcvq4DIriAg+w6iYKgo7kvZ"+
                                 "6kzmaJs1YzWpJQrYWGONUzNNk1YqavNUU6kF4lQul7v+7r2AgJg2T+B3vuf8LsHMM/PMXzPv8xwv"+
                                 "3nPg/bz7OQ5CAIy/c+fOtv7+fi1//p8KdXRx7eaP439Szi8u3G7+Kyxbq2FcPh/GpSkwLkmEoWIO"+
                                 "9GVR0JdHQ18aCX1xOHQlEdCXzLKvCOgKgqHL03DNhC43EG2ZPtBytWX6yqVNmw5tigeuJLmjNc4V"+
                                 "X1UkwHziXQFyQUIIy4Vy08oM2J5aj44XHkXHLx+EbedaWH++DJZHlsDyUCUsWyqgbCyCssG+1hfA"+
                                 "vDZPXWtyYKrNhKkmHcZlqTRgLoz3JdGIBOgXziZ0OLQ5gfg23RtfJE7Bu+EuaPtIQjQ48B+t5ZEq"+
                                 "tD+zCV2v7UbPm/vQ/fpLuH7gaXS8tBXtz29B+67NEs66vRbWbSthfbwG1p8R7rFqdUnIRVC2LITy"+
                                 "QBnMm4phXp8H0+osGGvoUXpTR09eprcuzPfCB7Mn4mh+jAyHCIGk76SynrdewY0/NqLn6H50E6bz"+
                                 "lR3oeFF4ZABig+qZX6yG9Qk7zLYV9NRyCWR99D5YHq4kSDkUCZEP06osmJanQr84FleLI/BVhh8+"+
                                 "jJ2E/YHjhGrYARZI13e/8TKV16H7yF50NTyHzj1PoGP3w2h/7n60P21Xvn0VLI+vgIVKLVuXwjrg"+
                                 "ASq2PEgvPFCuemAdla/JlqEVIZEAzJmvswJxIt4DdUHOQwBI2P7sZnTV75Lu7zr0vGo9odqf3QTb"+
                                 "k+tgo9XCAz1HD+CH1nPov/W9/ANC+m/dxN+/a0HP7+okgPCosSaN+TAPxupkGCrjoauYLQGas2fi"+
                                 "ZNJ01GnGy9+VAIYlSbDRss6923C97im76x9T3S7cTYtvvPcG7gxR+p+k//tedB9+EYbFcTAsYhVV"+
                                 "xLCKopgDkQxBOJpzg3FyrhcOhk6Q51WAxfGw0p0dv3qIifeY6vZdtHzHGsa3BrfOfSwPC+nrtNLS"+
                                 "AwRby5Jl1lenwHx/GaF34keb2X4KuNn0rsx+sUT5tnFJgLwQnEr1RX24mzynApBSVgLd3WHP+nbh"+
                                 "dibarXN/kQeF9Py+niXH2NZm08Uitiw5ek+4WPwN0TNE7gzIzZN/gL4oFPrCEOiKwnCtMBQtBGgS"+
                                 "ABH3yjN2gNmyzkWStT+zUZaccH3v+0fkISHdr+9lYhWxtHJhXMEYL2eMqxnjygTV1aJZiSZVHAZl"+
                                 "c7H9t4Cug09DX8BGVRSCq4T5OleDphQfNAz1gL50Fiyby2Rp2XYw5swHkXB3bqsxv/H2ITafEjad"+
                                 "giHWp8g9IaLZ6MvYGYuFtcFUOBNddU/Kvf6bPTDSQF2hhgAhaMmdSQDvfwFggigbCmUeiCYjSkxk"+
                                 "u5C+Ths7IJvLgPUrB60fEJFkehHromAYCoKgzwuAPtcXP1oMcr+rbidbdhCu0hPNOUFomueFhrAh"+
                                 "ACI+5rW5rOWqn7qbKDUhN96h9RtLCVAoAUwCQJTY0kEAw8IoGMrCYSjWwFAYCEO+Pwy5PujcvUXu"+
                                 "/9D8GfT5AQQIQkt2AJrmziCAq9xTAdgiRe1a7i9X+z5B+q63ywPtzz1MALp/PQHWEED0/BXpMLHG"+
                                 "B8S4KArG8nAYSzQwEsBY4AdjnjfMy+LlvgiDIc8X1wjWkuWH08nT0Bh6j9yTAG2cYib2bDFkJMQD"+
                                 "FXJTiLKZbdUOYP4JII3NawjAYgIsDIOpVANTcQBMBb4w5nvBlDvdfoJeIpCWEC0LvHE60QMNIS7y"+
                                 "exUg21+6VLRPZXMpIcrkphBlUxkBRGvl9BMAqzJhXpkGc80ggKkyCqZF4TCXa2AuCYC5yJcQnjDl"+
                                 "DQIY8zyhzfXCxQWeOJMwGY3Bd8vvJYCWVMaqRMY4G2YxajeVyOQT0rFriwogPMA8Ma8mwKp0QgxW"+
                                 "gXlJNMyV4VAqNFDKCFDsA6XQE+0bM+S+rITcaTR0GlrTpuJM/EQ0aobMAm36DNlIRGylEkKIO4KQ"+
                                 "nrfrCVDE7+iBddxbkwVldTqU2lS5L8RcHQ2lKgKWxcGwlAfAUuoDS7Eneg5sk/u3Pz0GU84UXlAm"+
                                 "ozV1Ms7GuqIxyEnuqQApU2UvELUtYiwuGV2HX5IHROs1s0SVDbx4rMv5twDKUjay+whQGQxrRSCs"+
                                 "5b6wlniiz6qWYffuDTBnu0OXMRGX5rnh4xgXHAocI/ckwLW5k1iKoWoYWGJihovLhZhyQm68/1uG"+
                                 "gNavZYjWZBIgDcqqwRAoy6JhJYC1SgAEwFrmg9767XLvDt0vgMyZbtClTUBrkgs+jhqHQ/6Ocl8F"+
                                 "SLoXbXlBsqWKBiPLjBBdr70gDwkRtyVVeQaVs2Jq50FZmQilJhYWCRAOa6WGAP7o2avWv5De/Vth"+
                                 "zXaFku4CXcrduJTgjLOzxuKQ30i5LwGuxk9AG+tTdERDVQLnOEOxkhC8Un3/6UfyoJAb7/0G5lpa"+
                                 "X5tC5clQViRAWT4HlqVRBAiDrUqD3td22k8z9iePwJbjCmumC5Q0Z+iTx+JS7FicDR+FRt8R8owK"+
                                 "EMtLYrqnDINIRnGHkxDCE7UZuPXJh/KwkL4OBT1Hfo327UupPI4rBh2PV6D38LPoazfaT1F501uw"+
                                 "FbhLANuCu6GkOkGfOAqXYhxxNnQkGr2HyXMqQIwztKlTZRh0pZxohJCeqJ7LhkMQrq4Dz8jLxn8T"+
                                 "EfPe+idgK5wMW54bbFn3wJo2Dsq80dDF34XWqBE4oxn+zwBXop1kIoo7vU6MTjFWOcEMlXGqN+SK"+
                                 "p/vTcX3/Dtz+8gytHbx89NlM+OGLE+jZw+v8EiZioQesee6wZk2AldZbUsfCnOwIXewIXIwcjtOa"+
                                 "YWjwGgLwTeQYXE5ww9X506BlLmjzNfIG08ac0Il7vVzR0Imr1UI+UBZy9JaHcQCFwFg2ky2Y7beY"+
                                 "mc7mY86fCnPOJJiz3Jh442Gm603Jo2CMH4lrs4ehOWIYTgU5oN5TqlYBLoSNwkXW5t+SJuGbtBn4"+
                                 "li+a7zi3L+cH4zIn5RWuy7zNXOGsF3f7q0Wc7YVivAZAy8GjzffmPJkBXbYHdFks6Qw36Oe7QJ8y"+
                                 "DrqkMWiLuwvXYobjm1kO+DLEAcf8HbB3uh1APEy+LIrEJ+FO+DxmAj6Pc8cXSR44n+qJ82k+OJ/u"+
                                 "h/O8y59L98WFdPF/b35ypXnykTEdzWytzalT0JLijotz3XAxeQJaEl3QEu+Mi3PGoDWGxkWOkJZ/"+
                                 "TuVNgQ5409sBhzPC1IeJeJrZPjuNowGO+FOIE/4cPh7vRbrieMxEHJ8zGcdjp+B4nAeOxfEzdjI+"+
                                 "kGsSlzvP3IsTMa44SfBT0eNxOsoZZ9hkTkWMxcmw0WgKdURT8AjGfDg+otvfp+VC+cvTHPDtsXfU"+
                                 "pxm9IB+npk9P40h2JPZ4O+Jl39HY5z8G+wKc1MVHxJ5AZ7zK18yrgU6o4+fBILGcsJ/n6vxH46Cf"+
                                 "IxrZ3Rr87kKdz0g0+IzAIR+R7VxeDjjImO+j24XlduXq43Tghfx/fp438Ecqd3D4B8s/MHJUdZ8L"+
                                 "AAAAAElFTkSuQmCC")),0,$$.Length)))))
#endregion
$RestartComputer.add_Click({Restart_Click($RestartComputer)})


#~~< Invite de commande >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$CMDPrompt = New-Object System.Windows.Forms.Button
$CMDPrompt.Location = New-Object System.Drawing.Point(607, 0)
$CMDPrompt.Size = New-Object System.Drawing.Size(79, 93)
$CMDPrompt.TabIndex = 8
$CMDPrompt.Text = "CMD"
$CMDPrompt.TextAlign = [System.Drawing.ContentAlignment]::BottomCenter
$CMDPrompt.UseVisualStyleBackColor = $true
# Icone de l'invite de commande
$CMDPrompt.Image = ([System.Drawing.Image]([System.Drawing.Image]::FromStream((New-Object System.IO.MemoryStream(($$ = [System.Convert]::FromBase64String(
"iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAABGdBTUEAALGPC/xhBQAAAAlwSFlz"+
                                 "AAAOwQAADsEBuJFr7QAAAgdJREFUWEftl01rGlEUhocoFQmioLgQBL8QQUUQRRQRRFRE1L/RfSk0"+
                                 "kI1J1I5JmJioIckPao0f0VW7Snf9C3bVt/f4xYxOggRHA/WFB2eu58555nIXc7l9dh7+/Pq4fPYV"+
                                 "2+SsWi+z1h8YB1ylxv/9+fwbox+/GM8b5eNRQ/aXJFhz80RCEG7Gg+EIC55G6MsyRH8wRG/BE7r9"+
                                 "KTRO8wZDVsPq6H8af+wN0On28f2xh2+d7oKZgJNxyLXaD+NSqQSiWCyiUCggn88jl8shm80inU4j"+
                                 "lUohmUwikUggHo8jFoshEokgFAohGAwiEAjA7/fD6/XC4/HA7XbDbrfDYrHAaDRCq9VSwwUzATdD"+
                                 "xwTudyvQbN3tWKB992dZYJ6XBCiKCVDmK0CZC1AUEWg0byfN5QReWwHKXMDn88HlcsHhcMBms8Fq"+
                                 "tcJkMsFgMECv10Oj0WxGIBqNTt7U6XRO6ihqtVry8HVYW4BCTenNKOKHEHJj6yARuLppSwTEm5CW"+
                                 "TzxxGYr4+rWI50kEhEZLIhAOh1c2zaaRFchkMjCbzSvFSrAiQLt7eacqiUSgxl9CpVKtFCmJRGB2"+
                                 "s1X2AnuBvcD7EqBv9ONyZUyDb+G0WkeVvwB/IaBWF1CpneNEpk7Mp89fmqz59KuYhQ4I9I1OA2S1"+
                                 "DajX9FzAcjC7IBvdlqBe05PRfx6O+wdC5OY+KMj/aAAAAABJRU5ErkJggg==")),0,$$.Length)))))
#endregion
$CMDPrompt.add_Click({CMD_Click($CMDPrompt)})


#~~< Panneau de controle >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$ControlPanel = New-Object System.Windows.Forms.Button
$ControlPanel.Location = New-Object System.Drawing.Point(437, 0)
$ControlPanel.Size = New-Object System.Drawing.Size(79, 93)
$ControlPanel.TabIndex = 7
$ControlPanel.Text = "Control Panel"
$ControlPanel.TextAlign = [System.Drawing.ContentAlignment]::BottomCenter
$ControlPanel.UseVisualStyleBackColor = $true
# Icone du Panneau de Controle
$ControlPanel.Image = ([System.Drawing.Image]([System.Drawing.Image]::FromStream((New-Object System.IO.MemoryStream(($$ = [System.Convert]::FromBase64String(
"iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAABGdBTUEAALGPC/xhBQAAAAlwSFlz"+
                                 "AAAOwQAADsEBuJFr7QAAA/lJREFUWEftlttPk3ccxt/ESxMvpsxsiUvUpWZ3S/wfdrEYs5gsTNhB"+
                                 "Nw9bNiZDpzIP4GKWecA5QA5ONBOEhl1M0GAyMzfcPENBpKVAS+nwQEDDAlVZfeuz5/lBOdgW6+Ld"+
                                 "+kue0PcNfT/P9/jWSp3USZ3oWZJzZOi1nKN4Fi3JrsCslQXPrvR9Q+PYyaMHOm8BlTefruN9wI9/"+
                                 "ASUBYL8P2NsFfNsJfEPt9gJfdwD5HmCnG9jeDmy7AeS2AVuoHfwsE+PYySMDevgPwUmduWOj7+8H"+
                                 "CIVCE9J1w20bpb2EEbiLsDzCtlNfEbiVwM0EbaJyWoHsFuBzF/AZ9UkTsJHXSRm4PBg2wNPuAayr"+
                                 "6zGfw+3r8GCg0XxuHhyNC3+FX55fGsB8pufFKXq5PIiPrwFf0MhTDdQxQkE2numFo7DdSNf2WQfs"+
                                 "8w6M+gswPDyMysCjmMgFrw1EcIrPkuopZ08EaYcCWHsV2JCMAaVZkRt4EVXsGTNQTwMN1C8LEOpr"+
                                 "gO9eaAK+9Fg/Fhf1YXZB9zQ48i3Us2fm0cBHNJDVnIQBwZR2Az/kgaOk09wLn8tAuDED//z6Bh62"+
                                 "5JosRCMXPKspMi3taRLBgkurrwCfsgxJGcj4ycfI3TTghaO0y9yLSuCoBN/gimARDajhBHayBIpa"+
                                 "qqNqWIK5NPDBJTYis/CfDDjKKP6ds+cGrHwXllV6jQFFLvjrR/tNt8uAwFbubwYunaRk4L2LwPpk"+
                                 "DKgHalr6WQIZYAlkglpY6IG1ywUrrwnVrtvouhuKGbUn0y6wUXEAmTSwlmWY2QDnW3OuLJgpUB/I"+
                                 "CDV3T6uBZ9Z2megLO+2YORdcKY9GfpIL64Q/ghdo4J0LwJrLMxjQhiunAS2Z63dHjQllQuVYWevD"+
                                 "8iqviVzw4/5wDFxzrqgFVwkE/3lcMpD+B/Ah+yChAa1XwfkMFPvp/qaN4NDYJhwZGTHgtoH7cSMX"+
                                 "XHP+UllwWtoFltJKg3j7PLCKZUho4BgNROGF3PEHqQPd3Pfc9bnc4YnWaxSuOdeoqdvVcKq50q7I"+
                                 "BV/RCLzP64QGKtiA8eC7uXKfB/yt34F3/5zBwBGmX/AS/2M4gzaqqRO9Nsp9tkn7914b33XYKKCa"+
                                 "BjGhZOHLqQzeS2jgMNOvyAW3nVy5UtUCPCq3YiSwVTFmwMq+AiunGdYmTslm7oktbooju1XqMBJ8"+
                                 "2Tkam8lAWc9Y2ot8j03kVQG+drttHJwS+T6Pjb3u6RlIJnLB36TSeT9xD2gC2ANFzIJKcYD1n/pj"+
                                 "4kv2gN7neqXqraYXi3a71qs2nJaM5lyjpm5Xw6nmSrsiF3w178c18GrW4ZifZPPWFJt/fu6K95Ms"+
                                 "dVLnf3os618/TIziHJ6OYwAAAABJRU5ErkJggg==")),0,$$.Length)))))
#endregion
$ControlPanel.add_Click({ControlPanel_Click($ControlPanel)})


#~~< Explorateur de fichier >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$FileExplorer = New-Object System.Windows.Forms.Button
$FileExplorer.Location = New-Object System.Drawing.Point(352, 0)
$FileExplorer.Size = New-Object System.Drawing.Size(79, 93)
$FileExplorer.TabIndex = 6
$FileExplorer.Text = "Explorateur"
$FileExplorer.TextAlign = [System.Drawing.ContentAlignment]::BottomCenter
$FileExplorer.UseVisualStyleBackColor = $true
# Icone de l'Explorateur de fichier
$FileExplorer.Image = ([System.Drawing.Image]([System.Drawing.Image]::FromStream((New-Object System.IO.MemoryStream(($$ = [System.Convert]::FromBase64String(
"iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAABGdBTUEAALGPC/xhBQAAAAlwSFlz"+
                                 "AAAOwQAADsEBuJFr7QAAASJJREFUWEftljFuwkAURH2k1CkgVQouEW6Qu+AuFRJnQKLnAMESDZFA"+
                                 "ShMoaS2wFhmNM6swRN8Lv8JPehXzZ7bDWUdHQ1n0h4fiJZhc9BblZ/8Jp/ehKX+e/pxVxI8oi97+"+
                                 "ro9oij/m+dlqN74wfkC1egthmyc6GmKWxOX/eVwOQrV+F6XtxCxRIU8xS1TIU8wSFfIUs0SFPMUs"+
                                 "USFPMUtUyFPMEhXyFLNEhTzFLFEhTzFLVOhrMwmvs+/f/4e21rd1h+rGLFGhW8Yb6w7VjVmiQqow"+
                                 "RdWNWaJCqixF1Y1ZokKqLEXVjVmiQtayWOsNZokKWctirTeYJSpkLYu13mCWqJC1LNZ6g1lSf6f9"+
                                 "DVnLYm034ptQocrw01VSbjoemSw7AR0vBdoltyuNAAAAAElFTkSuQmCC")),0,$$.Length)))))
#endregion
$FileExplorer.add_Click({FileExplorer_Click($FileExplorer)})


#~~< Powershell >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$Powershell = New-Object System.Windows.Forms.Button
$Powershell.Location = New-Object System.Drawing.Point(522, 0)
$Powershell.Size = New-Object System.Drawing.Size(79, 93)
$Powershell.TabIndex = 5
$Powershell.Text = "Powershell"
$Powershell.TextAlign = [System.Drawing.ContentAlignment]::BottomCenter
$Powershell.UseVisualStyleBackColor = $true
# Icone de Powershell
$Powershell.Image = ([System.Drawing.Image]([System.Drawing.Image]::FromStream((New-Object System.IO.MemoryStream(($$ = [System.Convert]::FromBase64String(
"iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAABGdBTUEAALGPC/xhBQAAAAlwSFlz"+
                                 "AAAOwQAADsEBuJFr7QAABExJREFUWEftlvtPFFcUx/kT+FP4oUmbJmVdFrCwLrtAMPY3bQImVcqu"+
                                 "vFYedqGIu8C6Ypq0/oSP2ibGWGjSBFGyio8qULewWrQW1pbXyorbFeSleDzn3js7M3uHR/sz3+Rk"+
                                 "eMzcz7nnnvOdSdvRjoz0yeHgfktNCPK+iqTEBHyKoVy3Hce013G8jkN+8yTsOR5zCKReWVWD8eLO"+
                                 "d6BE0am3UBRYg0L/Cjg6lsDRvgj2tldQ4PsXbN55sLXGcLHnYG2ZBevX02zxPM/fLGmC7W58Crsb"+
                                 "nkBu/RjkHH0EOe4w/vwYbCdiHoFUZaoIZtCDEvzkCrjOYwIaeIH3JS7yAuFzsKclivAZDm/aAF7H"+
                                 "4dm1I+x3mzfuFFhVVH5amCVwaj0Jn5h7B6T+8Joe3qqFT0F+0z+4+2fG8KMczo93AjcSzxBYVZnl"+
                                 "/V0E5fA3CF8Fh3+JwRX1j65uDqfzbvwL4X8awi3Vv7GjEki9LJVDES280L+M5/4afh5eE3iu66PL"+
                                 "WPoN4McU+GPIrfsD4Q8h2z0K2TW/I/wBZFUNUe8EBVIVnn86ZZwKt7cvgN2XwPKvCjxX+2VqOAN4"+
                                 "owG8VoEPsyrgmkYNOOCg0kjwtgSeeRzLPs92rtXJ7vn/BM+qHGR9Ye94LY+gqeKWp8AXl+H4N4Ir"+
                                 "43Z9RN8T/p9ioukQ3mAAr1Hh5iP3WNXsgXi6wKoyu+4HlVnfCK7M+uizFYHn6rgSVTse4cq4MXi1"+
                                 "Ct/lugvW47GIQOpFGW/XaEq8kzA+q++J0gDtXJ11pePR2JJwuuJYdwmkKlPF7Qw6x62NZippNH2h"+
                                 "BYHm+vbysAF8CMyV98Hs+hV2OW+zIykMrMkGlOW656RdSnCDWT/03Yy0+1eLK5BX8aMx/AjB7wD2"+
                                 "GGtWe2BVNiBz5WAXA28B93e/gMXldYHl6h8ch8yy77HEdzaFm768yfpJIPWyuMMRCa4xmhLfFNwd"+
                                 "03c/7drbdRM+LL0iGU0Sjkkp8MzyIL3QjAwolE7Wqcw6h/OmI/jhM1GIxt8ILNdYZA5Kai+ByXnL"+
                                 "cNaTcPy/AqfEijvXZQPCMXFQeaVxa56GizcSAqnqwi8h+ODAD2BBqDGcdzw1nQKn4C4LsgFZqkMe"+
                                 "gmrhe9tmpVmnkn/e3AMff9HLZv1g51M4fy0K5/pmMWbg7NVpjCk42zsJzm/CWPoBBN9IJmBtmcEG"+
                                 "BNmActwjwdRZT905a7SDF9nZKkazlYrrOVgJmy9hbEDkYFo4Gc2Z3pdiGeCNVtYtXE41moWlt+IO"+
                                 "Y1mdl5JwakR8y8oGlFP3kBmQkdGUn34AtqoeyHQOcLjmi4bG7bOWEJSduIbRx6P1KovS1l7YV98D"+
                                 "H5XhsyIBur/oNOwXWFXZ7rAzv2lSN+vK222zL5rNZl2BaoM2VBIA2YCwpB4qeSpc/qLBt9v/hFPY"+
                                 "vIm4QOqV2/DIQTDKcOPAhLYZdG/q82RuhuXf0Y7S0tLeA2cnJwpPGMfmAAAAAElFTkSuQmCC")),0,$$.Length)))))
#endregion
$Powershell.add_Click({PS_Click($Powershell)})


#~~< GP Update >~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$GPUpdate = New-Object System.Windows.Forms.Button
$GPUpdate.Location = New-Object System.Drawing.Point(267, 0)
$GPUpdate.Size = New-Object System.Drawing.Size(79, 93)
$GPUpdate.TabIndex = 4
$GPUpdate.Text = "GP Update"
$GPUpdate.TextAlign = [System.Drawing.ContentAlignment]::BottomCenter
$GPUpdate.UseVisualStyleBackColor = $true
# Icone de GP Update
$GPUpdate.Image = ([System.Drawing.Image]([System.Drawing.Image]::FromStream((New-Object System.IO.MemoryStream(($$ = [System.Convert]::FromBase64String(
"iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAABGdBTUEAALGPC/xhBQAAAAlwSFlz"+
                                 "AAAOwQAADsEBuJFr7QAACBpJREFUWEfVl1tMm+cZx7nYJk3bRaRGmqrdLRe92FRpN7tao02Tpkmb"+
                                 "IlXpIQmZumZZUpojOXFwbIMxNjYYGxtj8BmDbWxjbIM5BmOTEszBBWPOiRMIJTRxKSEkKQES/nu+"+
                                 "z2RJPLaRdpq0V/oLZD4/7+/9P4fvJe3/ctmdbluNsz7kcDiCzgZP2Ol0Rm02+5TD5Zqzu7yLqnL1"+
                                 "18UlspliuTwqkcm6ZQqF32A225UqtcFkMqmMRrO0vKJC6HZ7T2+FfL3VFx3FvrNc/G7ffrzzm9/i"+
                                 "13v34nhGBgaGRtA3FcfhI0dhdTnAkxaBKypEdn4eMjkcnLt8GWeys3A6KwsZ5y+AJxJjK+TrrXA0"+
                                 "hmh8BjpPM3R1btR5mtAXG8f0l1+hdTCKg3/5GDaXCwKpFDyhCDkFBbiUl4fzBHA2Jxtnsi7ieGbm"+
                                 "dwAYjoFZ66TlJ99gfmkJwzNzuDoRhy8cwaGPkgD5RWLwCgqRIxAgi8/HRS4X53JzcTY7B5+cO/cq"+
                                 "wOTkyFs3x9uNs+PemZkJ71ezE77ECzUmZiebErNTpMnGxMxkC25Pt2J2qgVz0y2YHuvAyKAJQyN+"+
                                 "+HojSN9yIF8iAa+wEJyXATi55ACTgvPgPweIRCLfHx3oFD+6fx3Y/BLYmKHj3XxFm2tJvfL501vY"+
                                 "fDqPL2b6MRIuQV/nGZRp9fjo6DHY6uvZFPBFInAoBdn5+bjE4+MCpeE81cMpSkO+RJoE6HU4fjgd"+
                                 "vVbL2Lr5dAWbG0uk+/9BS/T0IyQW76HdVwKb5k+QSz6EpqYeHx87AWdDAwqKi5EnLsJloRC5gjxk"+
                                 "UR0wEIwTZ3NyICyRJQHa2y0/uj42ZAeeUeCvKfAD0so2epjU5vLWc6sIBV0waPOg0fBRqi6H0mjD"+
                                 "oSPH4PE3oVAmIwgpC8EliOdOZFFXnCcIsVzxAuDGeMRGnlLwJYwOR9B/rRd9PddwrbsHnwWvojsQ"+
                                 "QvBKCF2k2zfH6dFFAniMYJcDHL6Aiq2Iio7ZUIn0I8fR2NyMItqAgWBSkScqYush6YYAlwhCqlK9"+
                                 "5ECsnwA2KHCCfuxQ5EYwYEdjZw9svnZo7V4oDHakH/0U/rY2FCuVdEo5QZQkIYqKyA3qjMJkXZRq"+
                                 "KrcB2LiLzfW7eLb2r8X8HRv3CGCFBah2+qCzuVFpbUCp3kop+ATNHR2QqzUsRJFCAVGpjHJeggIC"+
                                 "YecDFadKp0sFoM6mLthZCqhbsMwCcAUikhg5/AI6XTEOEkBboJM6Qkt1UYGS8nJIy+SUEjnEslKI"+
                                 "SAUEozGZUwFWiWGOAjPB6ZT/JObUjBbIgXn6uUgANkzcuYshmoy9YxMIDH7OpqCtsxNqvR7KKi3k"+
                                 "Gg0LIiMQxhFpGeNKGfS11lSAx3Sy2Z1pnURQwYAVo3N3XgE4fPQk2gNdqDKboTEaoSarleSGoqoS"+
                                 "CoKRaypQWlGB6jpHKgC12tP4zlKwQYMId1iAERrDrwKcQGf3VRjohDpLDarIao3RgHK9ls27imCU"+
                                 "2irY3A2pAMvA2hQFZoLfShFNx+fajNNzNDUxRwC16Bz4HOHxSYSGomjr7cMBqoGecBgWpxNGm521"+
                                 "Wl9jgbbawsIwqjSa4GpsSgWg4bLBFFiK3dtpbYIFCwZqcCLzIk5mXkI2T0AtV0ZFmIHw4CDsNA1r"+
                                 "nC7WarPdTjA2Vgarldyphae19QXADRaAevvJ8M5S8IR5I04TgAUGRyOUJgcklRYIynQswMDwEHvC"+
                                 "Oq8Hdreb7gcu1JIjjCsWh4OFauq8kgpAlb4a2f7EqVodJoAJFkAoU0Gs1EFImwvK9JSCDAzFYvC2"+
                                 "tsHt98PZ2AinzweH1wu7x0P3B4IitYVCLwGMMwDUfmuD22+YKgYUowRQTS8YITKzuPSmEyAnT0Rt"+
                                 "eAKxiXE0Uys20kT0trTAQ3L7m1Hvb0EDjWlPix8BcpgFCAb534tFwtUA9fajwM5S8DhEAIMEYIa6"+
                                 "xoUSbS2EKuM/HBibnkI7nbAlEICfQJpoMvpJrV1daCBXfAQW6utLApjN5p9+Fqhzbay0YvkLx471"+
                                 "dNmNrg4dLhfKwBUrwC+pQL68igWYiscR7L2GjqtXWQV6etBJsrrqoTUYKT3t6IlEkBa/3l14795Y"+
                                 "7EFi4P6zxxGsPxzeXo+2xPz+zSgLMB4Wo81fhou8QrrvFdBFg1IgkOAQpeD6zAx6qBNC1I7ddFKm"+
                                 "4pmNK6p0sNqdaL4SQHhoGGm3YqaHWHFjfbEeq4mdaX3Ji8VZK1odGahVvwe5wQaR2szan0zBp4jf"+
                                 "nkMvdUJvlLrB10jTUA9DdS30Fgtd19wYmpjGABVqml5xmN/tfn+pu/7g3Z0q5DmCdns6JPw/4vSp"+
                                 "g8gWSMGVKNkUPAeYnZ9HZGwU/aOjbA0ww8dYY0UdTT9m40qDbnH37t3vsDXwusvXEYLaWEOvVBky"+
                                 "c/g4eSEXGWcvIjObi2y+EOl/O4nbCwuITk1heHIS7d3dMFntaA0E0Ue27//gg1YKszsZ7VssBqDO"+
                                 "fwV6hw9KswNSdgAZ2NPzJGrWgfnEPcRuxBGL30D/cBSR2BhUlZpnP3nzzVNbYb79YgCERSWbqioL"+
                                 "Ctm865Anq4Q+9j7aRn/BAiwsJhC/s4DltQ3cWLiD9w58OEBf/XkywndcHJFCSurniMvAiCuhu5/c"+
                                 "hN9H0vDu0htsClboHxa6XUBrMm3s2rUrd+ur/93F55f/mCMq+wNHrBByxPIQVyRZ5UkVeDf9r0g8"+
                                 "WKZc7w/QYz9LPv0/WHw+/wf7Dvz5l2//ai9vz549x7Y+/jcrLe3vvmKkrCvh/FEAAAAASUVORK5C"+
                                 "YII=")),0,$$.Length)))))
#endregion
$GPUpdate.add_Click({GPUpdate_Click($GPUpdate)})


#################################################
# INSERTION DES COMPOSANTS
#################################################


# Ajout des composants  
$Panel1.Controls.Add($Info1)
$Panel1.Controls.Add($Info2)
$Panel1.Controls.Add($ComputerMGMT)
$Panel1.Controls.Add($MMC)
$Panel1.Controls.Add($RestartComputer)
$Panel1.Controls.Add($CMDPrompt)
$Panel1.Controls.Add($ControlPanel)
$Panel1.Controls.Add($FileExplorer)
$Panel1.Controls.Add($Powershell)
$Panel1.Controls.Add($GPUpdate)
$Panel1.Controls.Add($ComputerNameBox)
$MainMenu.Controls.Add($Log_Console)
$MainMenu.Controls.Add($Outputbox)
$MainMenu.Controls.Add($TabControl1)
$MainMenu.Controls.Add($Panel1)
$AccesRapide.Controls.Add($MO_FlushDNS)
$AccesRapide.Controls.Add($MO_ClearARPCache)
$AccesRapide.Controls.Add($MO_SON)
$AccesRapide.Controls.Add($MO_PROG)
$AccesRapide.Controls.Add($MO_FW)
$TabControl1.Controls.Add($AccesRapide)

# Icone Principal ( Console Admin, powershell )
$MainMenu.Icon = ([System.Drawing.Icon](New-Object System.Drawing.Icon((New-Object System.IO.MemoryStream(($$ = [System.Convert]::FromBase64String(
"AAABAAEAICAAAAAAIACxBAAAFgAAAIlQTkcNChoKAAAADUlIRFIAAAAgAAAAIAgGAAAAc3p69AAA"+
                                "AAFzUkdCAK7OHOkAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAAA7DAAAOwwHHb6hkAAAERklEQVRY"+
                                "R+2WW09UVxTH+Qh8FB6atGki4zCABRxmgGDqm5qASStluCMXO1DEGWAcMU1an1Bb28QYC02aIEpH"+
                                "8VJF6hTQYlUYldvIiFMEuSku19qXOefMPlzaZ/7JyuFyzv6tvfZa/3MStrUtM+04FNhnqwxCxteh"+
                                "uBiDzzDkdctxRH8dxesoZDaOw+6jEadAGpVSfjea1/4eZOSeeAe5/lXI8S2Ds20RnK0L4Gh5Ddne"+
                                "f8HumQV7cwQXewFZTdOQ9c0kWzzD/YwlTbBd9Y9hV90/kF47AmmHH0Ba9TD+/BDsxyJugdRkKQ4k"+
                                "0YMK/PgylJzFBHTwbM8rXOQlwmdgd1MY4VMc3rAOvIbDU6sG2e92T9QlsJqo/LQwS+DEWgw+NvMe"+
                                "SL3Dq0Z4sx4+AZkNz3H3T83hhzmcH+8YbiSaJLCakot+7yAoh79F+Ao4fYsMLtU7tLIxnM67/gnC"+
                                "H5nCbRV/sqMSSKNs5QMhPTzHt4Tn/gZ+HVgVeK4rQ0tY+nXgRyT8IaTX/I3w+5BaPQSplX8h/B5g"+
                                "j1HvBARSE55/ImUcD3e0zoPDO4flXxF4rtYL1HAm8HoTeJWED7Aq4JpmDdjnpNIo8JY5PPMoln2W"+
                                "7Vyv452z/wmeUtbP+sLR9kYdQUvxdXe2N6rC8W8El+N2ZdDYE75fIqLpEF5nAq/U4NbS26xqDn80"+
                                "UWA1WUvvBOSsrweXsz70dFngudouhrWOR7gcNwav0OA7S25h80ZCAmkUZbxVo8n3jMPotLEnCvy0"+
                                "c23WZcenlGtwuuJYdwikJkvxjSQ6x82NZiJmND3BeYHm+u7CgAn8LljL7oC15A/Y6brBjiTHv6oa"+
                                "UErJbRftUoGbzPqX308pu3+9sAwZxT+bw0sJfhOwx1izOvwrqgFZy/o7GHgTuK/zJSwsrQksV2//"+
                                "KCQX/oglvrkh3PLVNdZPAmlUavVwSIHrjCbfOwG3RozdT7v2dFyDjwsuKkYTg2NSEp5cFKAXmpkB"+
                                "BRPJOuWsczhvOoIfOhWGcPStwHKNhGYgv+o8WFzXTWc9Bsf/Szgllte+phoQjomTyquMW+MknLs6"+
                                "J5CafvgtCB/t/wlsCDWH846nppNwCu6yoBqQrSLoJqgevqdlWpl1KvmBxi749ItuNusH2x/D2cth"+
                                "ONMzjTEFpy9NYkzA6e5xcH07jKXvQ/DVWAJZTVPYgKAaUFr1YCB+1uN3zhrt4Dl2ttJoNlNeLQfL"+
                                "yPbOmRsQOZgeTkZzqvuVWAZ4oxV2CpfTjGZ+8Z24w1xZrvMxODUivmVVA0qruc8MyMxoik7eA3t5"+
                                "FyS7+jhc90VD47a3KQiFxy5j9PBovsSioLkbPq/tgk8K8VmRAN2fexL2CawmHD9XZsO4Ydbl222j"+
                                "L5qNZl1C9UEbyveDakBYUjeVPB6uftHg2+1/winw/KMCaVR63QMnwSjD9QMT2mLQvfHPk7mZln9b"+
                                "20pISPgAxFQnFWFRF0cAAAAASUVORK5CYII=")),0,$$.Length)))))
#endregion
$MainMenu.add_Load({MainMenuLoad($MainMenu)})

#region Event Loop

function Main{
    [System.Windows.Forms.Application]::EnableVisualStyles()
  	[System.Windows.Forms.Application]::Run($MainMenu)
	Add-Type -AssemblyName System.Windows.Forms
}

#endregion


#################################################
# COMMANDE DES BOUTONS
#################################################


# Nettoyage du cache DNS
function MO_FlushDNS_Click( $object ){
	$FDNS = ipconfig /flushdns | Out-String
	$outputbox.AppendText("`n") | Out-String
	$outputbox.AppendText("`n***** Nettoyage du cache DNS *****") | Out-String
	$outputbox.AppendText($FDNS)
	$outputbox.AppendText("`n***  processus terminer ***") | Out-String
}

# Nettoyage du cahe ARP
function MO_ClearARPCache_Click( $object ){
	$ARP = netsh interface ip delete arpcache | Out-String
	$outputbox.AppendText("`n") | Out-String
	$outputbox.AppendText("`n***** Nettoyage du cahe ARP *****") | Out-String
	$outputbox.AppendText("`n")
	$outputbox.AppendText($ARP)
	$outputbox.AppendText("`n***  processus terminer ***") | Out-String
}

# Vérificateur des fichiers système
function MO_StartSFCScan_Click( $object ){
	powershell -Command "Start-Process 'cmd' -Verb RunAs -ArgumentList '/c sfc /scannow'"
}

# Menu SON
function MO_SON_Click( $object ){
	Start-Process mmsys.cpl
}

# Menu Programme
function MO_PROG_Click( $object ){
	Start-Process appwiz.cpl
}

# Menu Pare-feu Windows Defender
function MO_FW_Click( $object ){
	Start-Process wf.msc
}

# Gestion Ordinateur
function ComputerMGMT_Click( $object ){
	Start-Process compmgmt.msc
}

# Microsoft Management Console
function MMC_Click( $object ){
	Start-Process MMC
}

function CMD_Click( $object ){
	Start-Process cmd
}

function ControlPanel_Click( $object ){
	Start-Process Control
}

function FileExplorer_Click( $object ){
	Start-Process explorer
}

function PS_Click( $object ){
	Start-Process powershell
}

function GPUpdate_Click( $object ){
	Start-Process gpupdate
}

function MainMenuLoad( $object ){

}


# Redémarrage du poste
function Restart_Click( $object ){
$Restart_Computer = New-Object System.Windows.Forms.Form
$Restart_Computer.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog
$Restart_Computer.MaximizeBox = $False
$Restart_Computer.MinimizeBox = $False  
$Restart_Computer.Text = "Redémarrer"
$Restart_Computer.TopMost = $true
$Restart_Computer.StartPosition = "CenterScreen" 
$Restart_Computer.Width = 400
$Restart_Computer.Height = 200
$Restart_Computer.Icon = ([System.Drawing.Icon](New-Object System.Drawing.Icon((New-Object System.IO.MemoryStream(($$ = [System.Convert]::FromBase64String(
"AAABAAEAICAAAAAAIACxBAAAFgAAAIlQTkcNChoKAAAADUlIRFIAAAAgAAAAIAgGAAAAc3p69AAA"+
                                "AAFzUkdCAK7OHOkAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAAA7DAAAOwwHHb6hkAAAERklEQVRY"+
                                "R+2WW09UVxTH+Qh8FB6atGki4zCABRxmgGDqm5qASStluCMXO1DEGWAcMU1an1Bb28QYC02aIEpH"+
                                "8VJF6hTQYlUYldvIiFMEuSku19qXOefMPlzaZ/7JyuFyzv6tvfZa/3MStrUtM+04FNhnqwxCxteh"+
                                "uBiDzzDkdctxRH8dxesoZDaOw+6jEadAGpVSfjea1/4eZOSeeAe5/lXI8S2Ds20RnK0L4Gh5Ddne"+
                                "f8HumQV7cwQXewFZTdOQ9c0kWzzD/YwlTbBd9Y9hV90/kF47AmmHH0Ba9TD+/BDsxyJugdRkKQ4k"+
                                "0YMK/PgylJzFBHTwbM8rXOQlwmdgd1MY4VMc3rAOvIbDU6sG2e92T9QlsJqo/LQwS+DEWgw+NvMe"+
                                "SL3Dq0Z4sx4+AZkNz3H3T83hhzmcH+8YbiSaJLCakot+7yAoh79F+Ao4fYsMLtU7tLIxnM67/gnC"+
                                "H5nCbRV/sqMSSKNs5QMhPTzHt4Tn/gZ+HVgVeK4rQ0tY+nXgRyT8IaTX/I3w+5BaPQSplX8h/B5g"+
                                "j1HvBARSE55/ImUcD3e0zoPDO4flXxF4rtYL1HAm8HoTeJWED7Aq4JpmDdjnpNIo8JY5PPMoln2W"+
                                "7Vyv452z/wmeUtbP+sLR9kYdQUvxdXe2N6rC8W8El+N2ZdDYE75fIqLpEF5nAq/U4NbS26xqDn80"+
                                "UWA1WUvvBOSsrweXsz70dFngudouhrWOR7gcNwav0OA7S25h80ZCAmkUZbxVo8n3jMPotLEnCvy0"+
                                "c23WZcenlGtwuuJYdwikJkvxjSQ6x82NZiJmND3BeYHm+u7CgAn8LljL7oC15A/Y6brBjiTHv6oa"+
                                "UErJbRftUoGbzPqX308pu3+9sAwZxT+bw0sJfhOwx1izOvwrqgFZy/o7GHgTuK/zJSwsrQksV2//"+
                                "KCQX/oglvrkh3PLVNdZPAmlUavVwSIHrjCbfOwG3RozdT7v2dFyDjwsuKkYTg2NSEp5cFKAXmpkB"+
                                "BRPJOuWsczhvOoIfOhWGcPStwHKNhGYgv+o8WFzXTWc9Bsf/Szgllte+phoQjomTyquMW+MknLs6"+
                                "J5CafvgtCB/t/wlsCDWH846nppNwCu6yoBqQrSLoJqgevqdlWpl1KvmBxi749ItuNusH2x/D2cth"+
                                "ONMzjTEFpy9NYkzA6e5xcH07jKXvQ/DVWAJZTVPYgKAaUFr1YCB+1uN3zhrt4Dl2ttJoNlNeLQfL"+
                                "yPbOmRsQOZgeTkZzqvuVWAZ4oxV2CpfTjGZ+8Z24w1xZrvMxODUivmVVA0qruc8MyMxoik7eA3t5"+
                                "FyS7+jhc90VD47a3KQiFxy5j9PBovsSioLkbPq/tgk8K8VmRAN2fexL2CawmHD9XZsO4Ydbl222j"+
                                "L5qNZl1C9UEbyveDakBYUjeVPB6uftHg2+1/winw/KMCaVR63QMnwSjD9QMT2mLQvfHPk7mZln9b"+
                                "20pISPgAxFQnFWFRF0cAAAAASUVORK5CYII=")),0,$$.Length)))))

$yes = New-Object system.windows.Forms.Button
$yes.Text = "Oui"
$yes.Width = 60
$yes.Height = 30
$yes.Add_Click({ Restart-Computer })
$yes.location = New-Object system.drawing.point(150,108)
$yes.Font = "Lucida Console,10"
$Restart_Computer.controls.Add($yes)

$RCInfo2 = New-Object system.windows.Forms.Label
$RCInfo2.Text = "Warning"
$RCInfo2.AutoSize = $true
$RCInfo2.Width = 25
$RCInfo2.Height = 10
$RCInfo2 = New-Object system.windows.Forms.Label
$RCInfo2.Text = "Attention"
$RCInfo2.location = New-Object system.drawing.point(145,19)
$RCInfo2.Font = "Lucida Console,10,style=Bold"
$Restart_Computer.controls.Add($RCInfo2)

$RCLabel2 = New-Object system.windows.Forms.Label
$RCLabel2.Text = "Ce processus redémarrera l'ordinateur."
$RCLabel2.AutoSize = $true
$RCLabel2.Width = 25
$RCLabel2.Height = 10
$RCLabel2.location = New-Object system.drawing.point(30,47)
$RCLabel2.Font = "Lucida Console,10"
$Restart_Computer.controls.Add($RCLabel2)

$RCLabel3 = New-Object system.windows.Forms.Label
$RCLabel3.Text = "Voulez-vous continuer?"
$RCLabel3.AutoSize = $true
$RCLabel3.Width = 25
$RCLabel3.Height = 10
$RCLabel3.location = New-Object system.drawing.point(100,74)
$RCLabel3.Font = "Lucida Console,10"
$Restart_Computer.controls.Add($RCLabel3)

[void]$Restart_Computer.ShowDialog()
$Restart_Computer.Dispose()
}

Main 

#endregion

#################################################
# FIN DU SCRIPT
#################################################


