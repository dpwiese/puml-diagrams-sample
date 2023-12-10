# Project directories
SRC := $(CURDIR)/src
OUT := $(CURDIR)/out

# Get variables from .env file
.EXPORT_ALL_VARIABLES:
include .env

# Define a pdf output that maps from each md file in src
SRC_FILES := $(wildcard $(SRC)/**/*.puml) $(wildcard $(SRC)/*.puml)
PNG_TARGETS := $(subst src,out, $(patsubst %.puml, %.png, $(SRC_FILES)))
PDF_TARGETS := $(subst src,out, $(patsubst %.puml, %.pdf, $(SRC_FILES)))

.PHONY: png pdf list lang fonts clean
.SILENT: png pdf list lang fonts clean

png: $(PNG_TARGETS)

pdf: $(PDF_TARGETS)

list:
	@echo $(PNG_TARGETS)

lang:
	@java -Djava.compiler=NONE -jar $(PUML_JAR) -language

fonts: | $(OUT)
	echo "@startuml\nlistfonts\n@enduml" | java -jar $(PUML_JAR) -tpng -pipe > $(OUT)/fonts.png

clean:
	@$(RM) -rf $(OUT)

$(OUT):
	@mkdir -p $@

$(OUT)/%.png: $(SRC)/%.puml | $(OUT)
	@java -DPLANTUML_LIMIT_SIZE=8192 -Djava.compiler=NONE -jar $(PUML_JAR) -o $(dir $@) -quiet -tpng $<

$(OUT)/%.pdf: $(SRC)/%.puml | $(OUT)
	@java -Djava.compiler=NONE -jar $(PUML_JAR) -o $(dir $@) -quiet -tpdf $< &>/dev/null
