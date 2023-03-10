/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   push_swap.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: arabenst <arabenst@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/02/22 17:14:05 by arabenst          #+#    #+#             */
/*   Updated: 2023/03/10 10:59:32 by arabenst         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "push_swap.h"

int	main(int argc, char **argv)
{
	t_push_swap	*data;

	if (argc == 1)
		return (0);
	data = ft_init_data();
	ft_get_input(data, argc, argv);
	if (ft_is_sorted(data->a))
		ft_exit(data, 0);
	ft_sort(data);
	ft_exit(data, 1);
}
