//transform: Matrix4.translationValues(0.0, -25, 0.0),  // translate up by 30

/*
void createTeamTaskDialog2(){
  showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      backgroundColor: HexColor("#F7F8FA"),
      //isScrollControlled: true,
      useRootNavigator: true,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                      children: [
                        const SizedBox(height: 11),
                        bottomHeaderData(context, "Create New Task"),
                        Divider(
                          color: HexColor(greyColor),
                        ),
                        Expanded(
                          child: Container(
                              padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 0),
                              decoration: const BoxDecoration(
                                //color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0))),
                              width: double.infinity,
                              //color: Colors.white,
                              child:childScrollView()
                          ),
                        ),
                      ]
                  )
              );
            });
      }
  );
}

Widget childScrollView(){
  return SingleChildScrollView(
    child:Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 5),
        blackTextWidgetSmall("Task Type", "#1C1C1E", 14, FontWeight.w500),
        const SizedBox(height: 6),
        //showTypeCategoryList(),
        SizedBox(
            height: 50,
            //padding: const EdgeInsets.fromLTRB(3.0,0,3,0),
decoration: BoxDecoration(border: Border.all(color: HexColor(greyColor)),
                  borderRadius: BorderRadius.circular(8)),

            child: showTypeCategoryList()
        ),
        const SizedBox(height: 15),
        blackTextWidgetSmall("Task Name", "#1C1C1E", 14, FontWeight.w500),
        const SizedBox(height: 6),
        showTaskName("Store Opening"),
        const SizedBox(height: 15),
        blackTextWidgetSmall("Task Description", "#1C1C1E", 14, FontWeight.w500),
        const SizedBox(height: 6),
        showAlertWidgetDescription(),
        const SizedBox(height: 15),
        blackTextWidgetSmall("Select Role", "#1C1C1E", 14, FontWeight.w500),
        const SizedBox(height: 6),
        showTaskName("Security"),
        const SizedBox(height: 15),
        blackTextWidgetSmall("Assign To", "#1C1C1E", 14, FontWeight.w500),
        const SizedBox(height: 6),
        showAssignedTo(""),
        const SizedBox(height: 25),
        SizedBox(
          width: double.infinity,
          height: 44,
          child: ElevatedButton(
            onPressed: () {

            },
            style: ElevatedButton.styleFrom(
                backgroundColor: HexColor("#4F23F1"),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      5,
                    ))),
            child: blackTextWidgetSmall("Create Task", "#FFFFFF", 16, FontWeight.w700),
          ),
        ),
        const SizedBox(height: 15)
      ],
    ),
  );
}
*/
