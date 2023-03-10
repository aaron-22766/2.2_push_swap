# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: arabenst <arabenst@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/10/14 17:40:26 by arabenst          #+#    #+#              #
#    Updated: 2023/03/10 11:51:55 by arabenst         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

NAME		=	push_swap

SRCDIR		=	./src
OBJDIR		=	./obj
LIBDIR		=	./lib
TESTDIR		=	./tests
TESTOBJDIR	=	$(TESTDIR)/obj
TEST		=	$(TESTDIR)/test

SRCS		=	$(wildcard $(SRCDIR)/*.c)
OBJS		=	$(addprefix $(OBJDIR)/,$(notdir $(SRCS:.c=.o)))
TESTSRCS	=	$(wildcard $(TESTDIR)/*.c)
TESTOBJS	=	$(filter-out $(TESTOBJDIR)/push_swap.o, \
				$(addprefix $(TESTOBJDIR)/,$(notdir $(TESTSRCS:.c=.o))) \
				$(addprefix $(TESTOBJDIR)/,$(notdir $(SRCS:.c=.o))))

# **************************************************************************** #
#                               CHANGE WILDCARD                                #
# **************************************************************************** #

CC			=	gcc
CFLAGS		=	-Wall -Werror -Wextra

RM			=	rm
RMFLAGS		=	-rf

LIBFT_DIR	=	$(LIBDIR)/libft
LIBFT_LIB	=	libft.a
LIBFT		=	$(LIBFT_DIR)/$(LIBFT_LIB)

ARCS		=	$(LIBFT)

CHECK_LIB	=	-lcheck -L $(HOME)/.brew/opt/check/lib/
CHECK_INC	=	-I $(HOME)/.brew/opt/check/include/

VIS_DIR		=	./visualizer
VIS_EXE		=	$(VIS_DIR)/build/bin/visualizer

$(NAME): $(LIBFT) $(OBJS)
	$(CC) -o $(NAME) $(OBJS) $(ARCS)

$(LIBFT): $(LIBDIR)
	git clone https://github.com/aaron-22766/libft.git $(LIBFT_DIR); make -C $(LIBFT_DIR)

$(LIBDIR):
	mkdir -p $(LIBDIR)

$(OBJDIR)/%.o: $(SRCDIR)/%.c | $(OBJDIR)
	$(CC) -c $(CFLAGS) $< -o $@

$(OBJDIR):
	mkdir -p $(OBJDIR)

$(TESTOBJDIR)/%.o: $(TESTDIR)/%.c | $(TESTOBJDIR)
	$(CC) -c $(CFLAGS) $< -o $@ $(CHECK_INC)

$(TESTOBJDIR)/%.o: $(SRCDIR)/%.c | $(TESTOBJDIR)
	$(CC) -c $(CFLAGS) -D ft_putstr_fd=putstr_ignored $< -o $@ $(CHECK_INC)

$(TESTOBJDIR):
	mkdir -p $(TESTOBJDIR)

$(TEST): $(TESTOBJS) $(ARCS)
	$(CC) -o $(TEST) $(TESTOBJS) $(ARCS) $(CHECK_LIB) $(CHECK_INC)

$(VIS_DIR):
	git clone https://github.com/o-reo/push_swap_visualizer.git $(VIS_DIR); (cd $(VIS_DIR) && mkdir build)

$(VIS_EXE): $(VIS_DIR)
	(cd $(VIS_DIR)/build && cmake .. && make)

all: $(NAME)

clean: test_clean
	$(RM) $(RMFLAGS) $(OBJDIR)
	make -C $(LIBFT_DIR) clean

fclean: clean
	$(RM) $(RMFLAGS) $(NAME)
	make -C $(LIBFT_DIR) fclean

libclean: fclean
	$(RM) $(RMFLAGS) $(LIBDIR)

re: fclean all

reb: fclean bonus

test: $(TEST)
	@./$(TEST)

test_clean:
	$(RM) $(RMFLAGS) $(TESTOBJDIR) $(TEST)

test_re: test_clean test

vis: $(NAME) $(VIS_EXE)
	$(VIS_EXE)

visclean:
	$(RM) $(RMFLAGS) $(VIS_DIR)

.PHONY: all clean fclean libclean re reb