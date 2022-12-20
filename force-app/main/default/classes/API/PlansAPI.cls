@RestResource(urlMapping='/PlansAPI/*')
global class PlansAPI {
    public static PlansService plansServiceInstance = PlansService.getInstance();
    public PlansAPI() {

    }

    @HttpGet
    global static List<PlansMapper> getPlansDetails(){
        RestRequest getReuest= RestContext.request;
        String app = getReuest.params.get('App');
        if(app.equals('Internal')){
           return plansServiceInstance.getPlanList();
        }

        return null;
    }
}
