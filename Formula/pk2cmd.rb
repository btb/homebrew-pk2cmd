require 'formula'
class Pk2cmd < Formula
  homepage 'http://www.microchip.com/pickit2'
#  url 'http://ww1.microchip.com/downloads/en/DeviceDoc/pk2cmdv1.20LinuxMacSource.tar.gz'
#  sha256 '903027de5036eda3a648decece4acfcefe91e754ef0d4eacba0e5ba8b18857fa'
#  version '1.20'
  url 'http://ww1.microchip.com/downloads/en/DeviceDoc/PICkit2_PK2CMD_WIN32_SourceV1-21_RC1.zip'
  sha256 '6f21baf42301067149ab0294b1e6ed6f9fb920f953a1d266e94ecc079f453227'
  version '1.21'
  
  def compileTarget
    osxVersion = `sw_vers -productVersion`.split(':')[1].to_i
    if(osxVersion == 4)
      'mac104'
    else
      'mac105'
    end
  end

  def install
    system "make","-C","pk2cmd/pk2cmd",compileTarget
    system "make","-C","pk2cmd/pk2cmd","PREFIX=#{prefix}","install"
  end

  patch :DATA
end
__END__
diff --git a/pk2cmd/pk2cmd/Makefile b/pk2cmd/pk2cmd/Makefile
index 1a23325..f194ba9 100644
--- a/pk2cmd/pk2cmd/Makefile
+++ b/pk2cmd/pk2cmd/Makefile
@@ -117,10 +117,11 @@ strnatcmp.o: strnatcmp.c strnatcmp.h stdafx.h
 	$(CC) $(CFLAGS) -x c -o $@  -c $<
 
 install: 
-	mkdir -p /usr/share/pk2
-	cp $(APP) /usr/local/bin
-	chmod u+s /usr/local/bin/$(APP)
-	cp PK2DeviceFile.dat /usr/share/pk2/PK2DeviceFile.dat
+	mkdir -p $(PREFIX)/share/pk2
+	mkdir -p $(PREFIX)/bin
+	cp $(APP) $(PREFIX)/bin
+	chmod u+s $(PREFIX)/bin/$(APP)
+	cp pk2cmd/release/PK2DeviceFile.dat $(PREFIX)/share/pk2/PK2DeviceFile.dat
 
 clean:
 	rm -f *.o
