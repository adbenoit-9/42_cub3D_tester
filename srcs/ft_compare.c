#include "get_next_line.h"

static int  ft_strlen(char *str)
{
    int i;

    i = 0;
    while(str[i])
        i++;
    return (i);
}

static int ft_compare(char *s1, char *s2)
{
    int i;

    i = 0;
    if (ft_strlen(s1) != ft_strlen(s2))
        return (0);
    while (s1[i] && s2[i])
    {
        if (s1[i] != s2[i])
            return (0);
        i++;
    }
    return (1);  
}

static char *gnl_str(char *file)
{
    int     fd;
    char    *str;

    fd = open(file, O_RDONLY);
    get_next_line(fd, &str);
    close(fd);
    return (str);
}

static int test(char *out, char *corr)
{
    char    *s1;
    char    *s2;

    s2 = gnl_str(corr);
    s1 = gnl_str(out);
    if (ft_compare(s1, s2) == 1)
    {
        printf("1");
        return (1);
    }
    printf("0");
    return (0);
}

int     main(int ac, char **av)
{
    if (ac != 3)
    {
        printf("ERROR\n");
        return (0);
    }
    return (test(av[1], av[2]));
}