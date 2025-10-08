import 'package:flutter/material.dart';

class Prodectpage extends StatefulWidget {
  const Prodectpage({super.key});

  @override
  State<Prodectpage> createState() => _ProdectpageState();
}

class _ProdectpageState extends State<Prodectpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios_new)),
        actions: [
         Padding(
           padding: const EdgeInsets.only(right: 20,bottom: 2),
           child: Icon(Icons.favorite_border_outlined,size: 32,),
         )
        ],
      ),
      body: Column(
        children: [
          Stack(children: [
            Container(
              height: 360,
              width: double.infinity,
            color: const Color.fromARGB(255, 255, 255, 255),
            child: Image.network("https://ik.imagekit.io/bbhed67kj/wp-content/uploads/2022/10/Luxury-Sakleshpur-Homestay-Near-Waterfalls-3-500x300.jpg",fit: BoxFit.cover,),),
            Padding(
              padding: const EdgeInsets.only(top: 320),
              child: Container(
                height: 677,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 243, 242, 242),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(28),topRight: Radius.circular(28))
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 15,left: 32),
                  child: Column(

                    children: [
                        SizedBox(
                          height: 53,
                          width: 413,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (context, index) {
                            return  Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Container(
                                  height: 45,
                                  width: 86,
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),
                                    color: const Color.fromARGB(255, 165, 165, 30)
                                  ),
                                ),
                            );
                          },
                          ),
                        ),
                        SizedBox(
                          height: 65,
                          child: Row(
                            children: [
                              Text("\$220",style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w800,
                                color: Colors.lightBlue,
                              ),),
                              Text(" /day",style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: const Color.fromARGB(255, 145, 143, 144),
                              ),),
                              SizedBox(
                                width: 232,
                              ),
                              Icon(Icons.star,color: Colors.pink,),
                              Text("4.5",style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),)
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              height: 65,
                              width: 65,
                              
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(31, 37, 34, 34),
                              borderRadius: BorderRadius.circular(18)
                            ),
                            ),
                            Column
                            (
                              children: [
                                Text("Owner Apartment"),
                                Text("AlbertFlores")
                              ],
                            )
                          ],
                        ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30,top: 25),
                        child: Container(
                          height: 68,
                          width: 420,
                         decoration: 
                         BoxDecoration( color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(20)
                         ),
                         child: Center(child: Text("Buy Now",style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 245, 240, 240)
                         ),)),
                        ),
                      )
                    ],
                  ),
                ),
                
              ),
            ),
          ]
          ),
        ],
      ),
    );
  }
}