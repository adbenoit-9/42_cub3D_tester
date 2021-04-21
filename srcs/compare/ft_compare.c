#include "../get_next_line.h"

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

static char *gnl_str(char *file, char *str)
{
    int     fd;
    char    *tmp;
    int     ret;

    fd = open(file, O_RDONLY);
    tmp = NULL;
    ret = get_next_line(fd, &str);
    while (ret == 1)
    {
        ret = get_next_line(fd, &tmp);
        free(tmp);
        tmp = NULL;
    }
    close(fd);
    return (str);
}

static int test(char *out, char *corr)
{
    char    *s1;
    char    *s2;

    s1 = NULL;
    s2 = NULL;
    s1 = gnl_str(out, s1);
    s2 = gnl_str(corr, s2);
    if (ft_compare(s1, s2) == 1)
    {
        printf("1");
        return (1);
    }
    printf("2");
    free(s1);
    free(s2);
    return (2);
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