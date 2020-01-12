#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>
#include <sys/mman.h>
#include <sched.h>
#include <time.h>

#include <unistd.h> // only for usleep

#ifndef NSEC_PER_SEC
#define NSEC_PER_SEC 1000000000L
#endif

void timespec_add_ns(struct timespec *a, unsigned int ns)
{
    ns += a->tv_nsec;
    while(ns >= NSEC_PER_SEC) {
        ns -= NSEC_PER_SEC;
        a->tv_sec++;
    }
    a->tv_nsec = ns;
}

int timespec_compare(const struct timespec *lhs, const struct timespec *rhs) {
    if (lhs->tv_sec < rhs->tv_sec)
        return -1;
    if (lhs->tv_sec > rhs->tv_sec)
        return 1;
    return lhs->tv_nsec - rhs->tv_nsec;
}


int main()
{
  struct sched_param param;
  int policy = SCHED_FIFO;
  struct timespec tsperiod, tsnow;
  unsigned int control_period_ns = 100*1000; // micro nano

  memset(&param, 0, sizeof(param));
  param.sched_priority = sched_get_priority_max(policy);

  printf("Setting up Realtime scheduler\n");
  if (sched_setscheduler(0, policy, &param) < 0) {
    printf("sched_setscheduler: %s\n", strerror(errno));
    printf("Please check you are setting /etc/security/limits.conf\n");
    exit (EXIT_FAILURE);
  }
  if (mlockall(MCL_CURRENT|MCL_FUTURE) < 0)
  {
    printf("mlockall: %s\n", strerror(errno));
    exit (EXIT_FAILURE);
  } 
  printf("Setting up Realtime scheduler finished!\n");


  clock_gettime(CLOCK_MONOTONIC, &tsperiod);

  for(int i=0;i<200;i++){
    // sleep until next clock time
    clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME, &tsperiod,0);

    printf("%d\n",i);
    printf("tsperiod :    %10ld.%09ld\n", tsperiod.tv_sec, tsperiod.tv_nsec);

    // exectute process
    // hogehoge();
    usleep(80); // this is a model of execution

    // set next clock time
    timespec_add_ns(&tsperiod, control_period_ns);
    clock_gettime(CLOCK_MONOTONIC, &tsnow);

    printf("tsnow    :    %10ld.%09ld\n", tsnow.tv_sec,    tsnow.tv_nsec);

    //modify next clock time if overrunning
    if (timespec_compare(&tsperiod, &tsnow)<0){
      // printf("oeverrunning\n");
      tsperiod = tsnow;
      timespec_add_ns(&tsperiod, control_period_ns);
    }
  }  

  return 0;
}
