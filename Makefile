# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jbremser <jbremser@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/05/03 11:33:26 by jbremser          #+#    #+#              #
#    Updated: 2024/05/17 17:02:31 by jbremser         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME = 		so_long

FLAGS = 	-Werror -Wextra -Wall -Wunreachable-code -Ofast
FILES = 	so_long.c \
			map_init.c \
			map_parse.c \
			utils.c \
			error_time.c \
			fill.c \
			mlx.c \
			assets.c \
			map_render.c \
			animations.c \
			moves.c \
			im_an_init.c 
			
BFILES = 	so_long_bonus.c \
			map_init_bonus.c \
			map_parse_bonus.c \
			utils_bonus.c \
			error_time_bonus.c \
			fill_bonus.c \
			mlx_bonus.c \
			assets_bonus.c \
			map_render_bonus.c \
			animations_bonus.c \
			moves_bonus.c \
			im_an_init_bonus.c 	

SRCDIR =	srcs
OBJDIR =	objs
BDIR =		bonus

MLXDIR	=	./MLX42
HEADERS	=	-I $(MLXDIR)/include
SL_H	= 	so_long.h
MLX		= 	$(MLXDIR)/build/libmlx42.a $(MLX_FLAGS)
MLX_FLAGS	= -ldl -lglfw -pthread -lm -L"/Users/$(USER)/.brew/opt/glfw/lib/"

LIBFT_DIR =	./libft
LIBFT =		$(LIBFT_DIR)/libft.a

SRCS =		$(addprefix $(SRCDIR)/, $(FILES))
OBJS =		$(patsubst $(SRCDIR)/%.c, $(OBJDIR)/%.o, $(SRCS)) libft/libft.a

BSRCS =		$(addprefix $(BDIR)/, $(BFILES))
BOBJS =		$(patsubst $(BDIR)/%.c, $(OBJDIR)/%.o, $(BSRCS)) libft/libft.a

ANSI_CYAN := \033[0;36m
ANSI_BLUE := \033[0;34m
ANSI_RED := \033[31m
ANSI_RESET := \033[0m

all:		$(NAME) mlx

libmlx:		
			@cmake $(MLXDIR) -B $(MLXDIR)/build && make -C $(MLXDIR)/build -j4
			@echo "$(ANSI_CYAN)MLX Library Compiled$(ANSI_RESET)"

$(OBJDIR)/%.o:	$(SRCDIR)/%.c $(SL_H)
			@mkdir -p $(OBJDIR)
			@cc  $(FLAGS) -o $@ -c $< $(HEADERS)

$(NAME):	libmlx $(OBJS) $(LIBFT)
			@$(CC) $(HEADERS) $(OBJS) $(LIBFT) $(MLX) -o $(NAME)
			@echo "$(ANSI_CYAN)Compilation Complete: $(NAME) $(ANSI_RESET)"

$(LIBFT):
			@make -C $(LIBFT_DIR)
			@echo "$(ANSI_CYAN)LIBFT Library Compiled$(ANSI_RESET)"

clean:		
			@rm -rf $(OBJDIR) 
			@make -C $(LIBFT_DIR) clean
			@rm -rf $(LIBMLX)/build
			@echo "$(ANSI_RED)Objects and Libraries:$(LIBFT_DIR) Cleaned$(ANSI_RESET)"
			

fclean:		clean
			@rm -rf $(NAME)
			@rm -f .bonus
			@make -C $(LIBFT_DIR) fclean
			@echo "$(ANSI_RED)Executable $(NAME) removed$(ANSI_RESET)"

re:			fclean	all

bonus:		.bonus

.bonus:	libmlx $(BOBJS) $(LIBFT)
			@$(CC) $(HEADERS) $(BOBJS) $(LIBFT) $(MLX) -o $(NAME)
			@touch .bonus
			@echo "$(ANSI_CYAN)Bonus Compilation Complete: $(NAME) $(ANSI_RESET)"

$(OBJDIR)/%.o:	$(BDIR)/%.c $(SL_H)
			@mkdir -p $(OBJDIR)
			@cc  $(FLAGS) -o $@ -c $< $(HEADERS)

.PHONY:		all	clean fclean re mlx bonus
