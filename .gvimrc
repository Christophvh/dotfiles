"Disable the print key when using cmd P to browse files
if has("gui_macvim")
	macmenu &File.Print key=<nop>
endif
