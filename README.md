# Analog Devices HDL

## Idee

Mit dem AD-HDL-Repo (https://github.com/analogdevicesinc/hdl) lassen sich die HDL-Toplevel-Designs der Eavl-Boards und AD-Hardware erzeugen. Diese koennen dann um unsere Designs erweitert und auf die Boards uebertragen werden.

## Build HDL Project

### Unsere Hardware

Die Hardware, die uns zur Verfuegung steht, ist das

 + `ADRV9361-Z7035(-ND)` mit dem dazugehoerigen 
 + Braek-Out-Board `ADRV1CRR-BOB` sowie (als alternative Hardware) das
 + Xilinx Zynq UltraScale+ MPSoC ZCU 102 Evaluation Kit (`EK-U1-ZCU102-G`) mit einem passenden AD-Board
 + `AD-FMCOMMS3-EBZ` **(*1)**.

Beide Boards sin **nicht mit Vivado Standard verwendbar**. Folglich braucht es eine **Vivado Enterprise Lizenz**.

**(*1)**: Das **FMCOMMS3 existiert nicht** im AD-HDL-Repo. Es ist aber (bzgl. Software und HDL-Projekt) identisch mit dem FMCOMMS2. Daher kann das Projekt eben des FMCOMMS2 auch aequivalent fuer das FMCOMMS3 verwendet werden.

### Voraussetzung

 1) Vivado Enterprise (lizensiert)

 2) Vivado muss fuer die Shell-Session, in der das Projekt gebaut wird, dem `$PATH` hinzugefuegt werden (exemplarischer Aufruf zum Installationsverzeichnis):

  `export PATH=$PATH:/home/markus/Programme/VivadoEnterprise-2021.1/Vivado/2021.1/bin/`
  `export PATH=$PATH:/home/markus/Programme/VivadoEnterprise-2021.1/Vitis_HLS/2021.1/bin/`

 3) Es muss auf den Branch des HDL-Repos ausgecheckt werden, der der Vivado-Version entspricht (siehe: https://wiki.analog.com/resources/fpga/docs/releases).

*(siehe auch: https://wiki.analog.com/resources/fpga/docs/build)*

### Build Prozess starten

Im AD-HDL-Repo muss make mit dem Verzeichnis aufgerufen werden, das der verwendeten Hardware entspricht. Will man also das Projekt fuer das FMCOMMS3 **(*1)** mit dem ZCU102 erzeugen, lautet der Aufruf:

`make -C ./projects/adrv9361z7035/ccbob_cmos/ all`.

### Erfahrungen & Fehler

 1) Zunaechst wurde vergessen, die `$PATH`-Variable (in der gleichen Shell-Session, in der auch MAKE ausgefuehrt wird!) um den Vivado-Pfad zu erweitern :: Resultat: Es gab eine Fehlermeldung, wonach der Befehl `vivado` nicht gefunden wurde.

 2) Es wurde versucht, den Prozess mit einer Vivado Standard Version durchzufuehren. Resultat: Es gab eine Fehlermeldung, wonach die Hardware (also der im Projekt verwendete FPGA) unbekannt ist.

 3) Der erste erfolgreiche Build-Prozess konnte mit Vivado Enterprise 2021.1 (unter Verwendung einer 30-Tage-Trial-Lizenz) durchgefuehrt werden. Bei oeffnen der `*.xpr` in Vivado kam es ABER zu der Fehlermeldung, wonach die Hardware (also der im Projekt verwendete FPGA) unbekannt sein. Eine Neuinstallation von Vivado Enterprise 2021.1 loeste das Problem. Die Ursache der urspruenglichen Fehlermeldung ist nach wie vor unbekannt. *Nachtrag: Vermutlich bestand das Problem darin, dass fuer Makeprozess der Pfad zu Vivado Enterprise 2021.1 angegeben wurde, womit das Projekt erfolgreich erzeugt werden konnte, aber bei Oeffnen des Projekts, Vivado ueber das Start-Menue gestartet wurde, was jedoch nicht die Enterprise sondern die Standard Version laedt!*

### Unklar

 + Fuer das ADRV9361-Z7035 gibt es vier verschiedene "Subprojekte" im HDL-Repo. Es ist klar geworden, dass diese fuer die verschiedenen Zusatzboards stehen. Wir verwenden das BOB. Fuer eben dieses gibt es aber wieder zwei Projekte mit den Bezeichnung "CMOS" und "LVDS". Es ist noch unbekannt, welches das fuer unser Board geeignete Projekt ist, falls es ein konkretes geeignetes Projekt gibt.

## Build BOOT.BIN

Link: https://wiki.analog.com/resources/tools-software/linux-software/build-the-zynq-boot-image

Der letztliche **Aufruf zur Generierung der** `BOOT.BIN` **lautet**:

`bash build_boot_bin.sh <...>/*.xsa <...>/u-boot.elf BOOT.BIN`

 1) Eine ausfuehrliche **Anleitung und das Skript** `build_boot_bin.sh` gibt es auf: https://wiki.analog.com/resources/tools-software/linux-software/build-the-zynq-boot-image

 2) Das `*.xsa`-File kann im Vivado-Projekt generiert werden via "File" -> "Export Hardware". Im Menue, welches sich oeffnet, wurde bisher stets die Option "Include Buitstream" angewaehlt.

 3) Die `u-boot.elf` kann dem Linux-Image von AD entnommen werden. Das Archiv `/BOOT/<verwendete_hardware>/bootgen_sysfiles.tgz` enthaelt die Datei. Das AD-Linux-Img gibt es auf: https://wiki.analog.com/resources/tools-software/linux-software/kuiper-linux
 
 4) **Voraussetzungen:** 
 
  + ES MUSS **Vitis Unified Software** auf dem Rechner installiert sein. Nur diese liefert das Xilinx Command Line Interface XSCT!

  + Der Pfad zu Vitis muss hinzugefuegt werden. Die geht durch das sourcen des Vitis Settings Files: `source /home/markus/Programme/VitisUnifiedSoftware-2021.1/Vitis/2021.1/settings64.sh`

## Versuchaufbau fuer Di, 14.05.2024:

 1) Das ADRV-Default-Projekt um UartLiteLoopBack erweitern.
 2) Das *.xsa-File erzeugen - **ACHTUNG: Dieses muss zwingend unter dem Namen "system_top.xsa" exportiert werden!**
 3) Ein PetaLinux-Projekt mit folgendem Aufruf erzeugen:

    petalinux-create -t project --template zynq --name 2024-05-14_adrv9361z7035uartLoopback

 **ACHTUNG: Das ADRV ist kein "zynqMP" sondern ein "zynq"!**

 4) Das Projekt unter Verwendung des erzeugten *.xsa-Files konfigurieren.
 5) Das Projekt bauen.
 6) Die BOOT.BIN erzeugen:

    petalinux-package --boot --fsbl images/linux/zynq_fsbl.elf  --u-boot images/linux/u-boot.elf --fpga images/linux/system.bit

 7) image/linux/ exportieren