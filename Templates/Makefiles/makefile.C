# ############################################################################ #
#                                  MAKEFILE                                    #
# ############################################################################ #

# Définition des cibles particulières
.PHONY: check clean dist_clean help

# ############################################################################ #
# ############################################################################ #


# Définition de variables :
#	# Compilateur
CC =			gcc

#	# Dossier contenant les sources
SRC_DIR = 		src
#	# Dossier où créer les fichiers objets
OBJ_DIR = 		obj
#	# Dossier où créer l'exécutable
BIN_DIR = 		bin

#	# Nom de l'exécutable
EXEC = 			out.exe
#	# Noms des fichiers sources
SRCS =			$(wildcard $(SRC_DIR)/*.c)
#	# Noms des fichiers objets (génération dynamique)
OBJS =			$(SRCS:%.c=$(OBJ_DIR)/%.o)

#	# Declaration des options
CFLAGS = 		-Wall -pedantic -ansi -g
#	# Declaration des librairies
LDFLAGS = 	-lm


# ############################################################################ #
# ############################################################################ #


# Enumération des cibles.

#	# Compile l'ensemble du projet
all: $(BIN_DIR)/$(EXEC)

$(BIN_DIR)/$(EXEC): $(OBJS)
	@echo "\033[1;32m"
	@echo "Compiler/Syntax messages: END."
	@echo
	@echo "======================================="
	@echo "\033[1;33m"
	@echo "Linker messages: BEGIN."
	@echo "\033[1;31m"
	@$(CC) $(OBJS) $(LDFLAGS) -o $(BIN_DIR)/$(EXEC)
	@echo "\033[1;32m"
	@echo "Linker messages: END."
	@echo
	@echo "======================================="
	@echo 
	@echo "$@ built successfully"
	@echo "\033[0m"

#	# Crée un fichier objet à partir d'un fichier source
$(OBJ_DIR)/%.o : $(SRC_DIR)/%.c
	@echo
	@echo "\033[1;33m  $<\n\033[1;31m"
	@$(CC) -c $(CFLAGS) $< -o $@
	@echo "\033[1;32m -> fichier objet créé."


# Enumération des cibles particulières.

#	# Supprime tous les fichier objets
clean :
	@echo "\033[1;33m"
	@rm -fv $(OBJ_DIR)/*.o
	@echo "\033[0m"

#	# Supprime tous les fichiers objets et l'exécutable
dist_clean :
	@echo "\033[1;33m"
	@rm -fv $(OBJ_DIR)/*.o
	@rm -fv $(BIN_DIR)/$(EXEC)
	@echo "\033[0m"

#	# Affiche le ReadMe
help :
	@cat ReadMe.txt | less
	
#	# Vérifie l'arborescence
check :
	@[ -e $(SRC_DIR) ] || mkdir $(SRC_DIR)
	@[ -e $(OBJ_DIR) ] || mkdir $(OBJ_DIR)
	@[ -e $(BIN_DIR) ] || mkdir $(BIN_DIR)


# ############################################################################ #
# ############################################################################ #

