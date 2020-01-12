package cn.offcn.service.customer;

import cn.offcn.entity.Customer;
import cn.offcn.utils.OAResult;
import cn.offcn.utils.PageView;

import java.util.List;

public interface CustomerService {

    /**
     * 添加客户
     * @param customer 客户对象
     * @return    自定义OAResult
     */
    public OAResult addCustomer(Customer customer);

    /**
     * 分页查询客户信息
     * @param currentPage   当前页
     * @param pageSize      每页要显示的记录数
     * @return PageView对象
     */
    public PageView<Customer> getCustomerCutPage(int currentPage, int pageSize);

    /**
     * 删除记录
     * @param ids  记录的id
     * @return
     */
    public OAResult deleteCustomerBySelected(String ids);

    /**
     * 根据id查询customer对象
     * @param id
     * @return
     */
    public Customer getCustomerById(int id);


    public OAResult updateCustomerById(Customer customer);


    public List<Customer> searchCustomer(int seacherType, String keyword, int orderby);
}
