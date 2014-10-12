#
# Set plotpg default display settings for this session.
#

# set object 1 rectangle from screen 0,0 to screen 1,1 fillcolor rgb "green" behind
   
PLOT_DEFAULTS = <<SQL  
	set plotpg.terminal='svg';
  set plotpg.border='lw 1 lc rgb "white"';
  set plotpg.xtics='textcolor rgb "white"';
  set plotpg.ytics='textcolor rgb "white"'; 
  set plotpg.xlabel='textcolor rgb "white"'; 
  set plotpg.ylabel='textcolor rgb "white"';
  set plotpg.title='textcolor rgb "white"';
SQL

#   set plotpg.key='textcolor rgb "white"';

ActiveRecord::Base.connection.execute PLOT_DEFAULTS

