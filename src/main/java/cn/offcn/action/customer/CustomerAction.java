package cn.offcn.action.customer;

import cn.offcn.entity.Customer;
import cn.offcn.service.customer.CustomerService;
import cn.offcn.utils.OAResult;
import cn.offcn.utils.PageView;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/cus")
class CustomerAction {

    @Autowired
    private CustomerService customerService;

    @Value("${pageSize}")
    private int pageSize;
    @RequestMapping("/{page}")
    public String forwardPage(@PathVariable("page") String page){

        return "customer/"+page;
    }

    @ResponseBody
    @RequestMapping("/save")
    public OAResult saveCustomer(Customer customer){

        return customerService.addCustomer(customer);
    }


    @ResponseBody
    @RequestMapping("/queryCustomer")
    public PageView<Customer> queryCustomerByCutPage(int currentPage){

       return  customerService.getCustomerCutPage(currentPage,pageSize);
    }

    @ResponseBody
    @RequestMapping("/deleteCustomer")
    public OAResult deleteCustomerBySelected(String ids){

        return customerService.deleteCustomerBySelected(ids);
    }

    @RequestMapping("/updateCustomerUI")
    public String updateCustomerUI(int id, Model model){

        Customer customer=customerService.getCustomerById(id);
        System.out.println("================>"+customer.getCompanyperson());
        model.addAttribute("customer",customer);
        return "customer/customer-edit";
    }

    @ResponseBody
    @RequestMapping("/updateCustomer")
    public OAResult updateCustomer(Customer customer){

        return customerService.updateCustomerById(customer);
    }

    @ResponseBody
    @RequestMapping("/searchCustomer")
    public List<Customer> searchCustomer(int seacherType, String keyword, int orderby){

        return customerService.searchCustomer(seacherType,keyword,orderby);
    }

}
