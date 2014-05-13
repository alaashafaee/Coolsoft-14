public class CoolSoft{
    public static void main (String [] args){
        Thread s = new Thread(new Runnable(){
            public void run(){
                while(true){
                    System.out.println(5);
                }
            }
        });
        s.start();
    }
}