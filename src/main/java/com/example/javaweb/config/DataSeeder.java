package com.example.javaweb.config;

import com.example.javaweb.entity.Category;
import com.example.javaweb.entity.Product;
import com.example.javaweb.entity.Role;
import com.example.javaweb.entity.User;
import com.example.javaweb.repository.CategoryRepository;
import com.example.javaweb.repository.ProductRepository;
import com.example.javaweb.repository.RoleRepository;
import com.example.javaweb.repository.UserRepository;
import com.example.javaweb.util.PasswordUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;
import com.example.javaweb.entity.NewsArticle;
import com.example.javaweb.repository.NewsArticleRepository;
import java.time.LocalDateTime;

@Component
public class DataSeeder implements CommandLineRunner {

    private final UserRepository userRepository;
    private final RoleRepository roleRepository;
    private final CategoryRepository categoryRepository;
    private final ProductRepository productRepository;
    private final NewsArticleRepository newsArticleRepository;

    @Autowired
    public DataSeeder(UserRepository userRepository, RoleRepository roleRepository,
                      CategoryRepository categoryRepository, ProductRepository productRepository,
                      NewsArticleRepository newsArticleRepository) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.categoryRepository = categoryRepository;
        this.productRepository = productRepository;
        this.newsArticleRepository = newsArticleRepository;
    }

    @Override
    public void run(String... args) throws Exception {
        // 1. Tạo vai trò mặc định nếu chưa tồn tại
        Role adminRole = roleRepository.findByName("ADMIN").orElseGet(() -> roleRepository.save(new Role("ADMIN")));
        Role userRole = roleRepository.findByName("USER").orElseGet(() -> roleRepository.save(new Role("USER")));

        // 2. Tạo tài khoản Admin mặc định nếu chưa có tài khoản nào
        if (userRepository.findByUsername("admin").isEmpty()) {
            User admin = new User();
            admin.setUsername("admin");
            admin.setPassword(PasswordUtil.hashPassword("admin123"));
            admin.setEmail("admin@techstore.com");
            admin.setActive(true);
            
            Set<Role> roles = new HashSet<>();
            roles.add(adminRole);
            roles.add(userRole);
            admin.setRoles(roles);
            
            userRepository.save(admin);
            System.out.println(">>> Đã khởi tạo tài khoản Admin mặc định: admin / admin123");
        }

        // 3. Tạo tài khoản User mặc định nếu chưa có
        if (userRepository.findByUsername("user").isEmpty()) {
            User user = new User();
            user.setUsername("user");
            user.setPassword(PasswordUtil.hashPassword("user123"));
            user.setEmail("user@techstore.com");
            user.setActive(true);
            
            Set<Role> roles = new HashSet<>();
            roles.add(userRole);
            user.setRoles(roles);
            
            userRepository.save(user);
            System.out.println(">>> Đã khởi tạo tài khoản User mặc định: user / user123");
        }

        // 4. Tạo danh mục và sản phẩm mẫu nếu database trống
        if (categoryRepository.count() == 0) {
            Category gaming = categoryRepository.save(new Category("Laptop Gaming"));
            Category office = categoryRepository.save(new Category("Laptop Văn Phòng"));
            Category component = categoryRepository.save(new Category("Linh Kiện Điện Tử"));

            System.out.println(">>> Đã khởi tạo 3 danh mục sản phẩm mẫu.");

            if (productRepository.count() == 0) {
                productRepository.save(new Product(
                        "Laptop Asus ROG Strix G16",
                        "Intel Core i7-13650HX, RAM 16GB, SSD 512GB, RTX 4060 8GB, Màn hình 16 inch 165Hz",
                        new BigDecimal("35490000"),
                        10,
                        gaming,
                        "/uploads/rog_strix_g16.png"
                ));

                productRepository.save(new Product(
                        "Laptop Acer Predator Helios 16",
                        "Intel Core i9-13900HX, RAM 32GB, SSD 1TB, RTX 4070 8GB, Màn hình 16 inch 2K 240Hz",
                        new BigDecimal("48990000"),
                        5,
                        gaming,
                        "/uploads/predator_helios_16.png"
                ));

                productRepository.save(new Product(
                        "Laptop Dell Inspiron 15 3520",
                        "Intel Core i5-1235U, RAM 8GB, SSD 512GB, Màn hình 15.6 inch FHD 120Hz",
                        new BigDecimal("13290000"),
                        25,
                        office,
                        "/uploads/dell_inspiron_15.png"
                ));

                productRepository.save(new Product(
                        "Laptop Asus Vivobook 14",
                        "Intel Core i3-1215U, RAM 8GB, SSD 256GB, Màn hình 14.0 inch FHD",
                        new BigDecimal("9990000"),
                        15,
                        office,
                        "/uploads/asus_vivobook_14.png"
                ));

                productRepository.save(new Product(
                        "Card màn hình ASUS Dual RTX 4060 Ti OC 8GB",
                        "Kiến trúc NVIDIA Ada Lovelace, DLSS 3, Ray Tracing thế hệ thứ 3, Tản nhiệt 2 quạt",
                        new BigDecimal("11490000"),
                        8,
                        component,
                        "/uploads/rtx_4060_ti.png"
                ));

                productRepository.save(new Product(
                        "Bộ vi xử lý Intel Core i5-13600K",
                        "14 nhân 20 luồng, xung nhịp lên đến 5.1GHz, TDP 125W, Socket LGA1700",
                        new BigDecimal("7890000"),
                        12,
                        component,
                        "/uploads/i5_13600k.png"
                ));

                System.out.println(">>> Đã khởi tạo danh sách sản phẩm mẫu.");
            }
        }

        // 5. Khởi tạo tin tức công nghệ mẫu nếu trống
        if (newsArticleRepository.count() == 0) {
            newsArticleRepository.save(new NewsArticle(
                    "Đánh giá chi tiết Intel Core Ultra 9: Kỷ nguyên AI PC thực sự bắt đầu",
                    "Thế hệ vi xử lý Intel Core Ultra mới (tên mã Meteor Lake) đánh dấu bước chuyển mình lớn nhất trong lịch sử kiến trúc bán dẫn của Intel. Bằng việc loại bỏ cách đặt tên 'Core i' truyền thống và chuyển sang tiến trình Intel 4 tiên tiến kết hợp công nghệ đóng gói Foveros 3D, Intel đang hướng tới mục tiêu tối ưu hiệu năng trên mỗi watt điện tiêu thụ. Điểm nhấn lớn nhất trên dòng chip mới là sự xuất hiện của nhân NPU (Neural Processing Unit) chuyên biệt cho các tác vụ AI. Thử nghiệm thực tế với các phần mềm đồ họa Adobe, Blender cho thấy khả năng xử lý nhanh hơn 40% trong khi tiết kiệm điện năng tới 2.5 lần so với thế hệ tiền nhiệm. Đối với người dùng phổ thông, AI PC sẽ thay đổi hoàn toàn cách chúng ta làm việc hàng ngày: từ tính năng làm mờ hậu cảnh thông minh, khử nhiễu micro bằng AI, cho đến việc chạy các mô hình ngôn ngữ lớn (LLM) cục bộ để hỗ trợ soạn thảo văn bản và lập trình một cách an toàn và bảo mật.",
                    "Thế hệ vi xử lý Intel Core Ultra mới đánh dấu bước chuyển mình lớn nhất trong 40 năm qua của Intel, tích hợp nhân NPU chuyên biệt xử lý các tác vụ trí tuệ nhân tạo trực tiếp trên thiết bị mà không cần kết nối đám mây.",
                    "Tinhte.vn",
                    "https://tinhte.vn",
                    "https://images.unsplash.com/photo-1591453089816-0fbb971b454c?w=800",
                    LocalDateTime.now().minusDays(1)
            ));

            newsArticleRepository.save(new NewsArticle(
                    "NVIDIA Geforce RTX 5090 lộ thông số: Sức mạnh đồ họa đỉnh cao thế hệ mới",
                    "Theo các rò rỉ mới nhất từ các chuỗi cung ứng bán dẫn, NVIDIA đang hoàn tất những công đoạn cuối cùng để trình làng thế hệ card đồ họa GeForce RTX 50-series (tên mã Blackwell). Trong đó, phiên bản đầu bảng RTX 5090 tiếp tục là tâm điểm chú ý với các thông số kỹ thuật cực kỳ ấn tượng. Dự kiến dòng card này sẽ sở hữu số lượng nhân CUDA vượt mốc 24,000 nhân, đi kèm bộ nhớ VRAM thế hệ mới GDDR7 dung lượng lên tới 32GB và băng thông đạt ngưỡng 28 Gbps. Kiến trúc Blackwell được thiết kế tối ưu hóa đặc biệt cho các thuật toán Ray-tracing thế hệ mới và tính năng DLSS 4 (Deep Learning Super Sampling) độc quyền. Nhờ đó, hiệu năng kết xuất đồ họa thực tế được kỳ vọng sẽ tăng từ 50% đến 60% so với RTX 4090, đồng thời mang lại khả năng huấn luyện và chạy các ứng dụng AI tạo sinh (Generative AI) tại nhà với tốc độ vượt bậc.",
                    "Dòng card đồ họa cao cấp tiếp theo của NVIDIA dựa trên kiến trúc Blackwell hứa hẹn mang lại sự nhảy vọt về hiệu năng ray-tracing và xử lý mô hình AI cục bộ.",
                    "GenK.vn",
                    "https://genk.vn",
                    "https://images.unsplash.com/photo-1587202372775-e229f172b9d7?w=800",
                    LocalDateTime.now().minusDays(3)
            ));

            newsArticleRepository.save(new NewsArticle(
                    "Thị trường Laptop Việt Nam: Xu hướng chuyển dịch mạnh mẽ sang dòng máy AI PC",
                    "Báo cáo thị trường bán lẻ công nghệ quý 1 năm nay cho thấy một xu hướng chuyển dịch vô cùng rõ ràng của người tiêu dùng Việt Nam khi chọn mua máy tính xách tay. Cụ thể, doanh số các dòng laptop sở hữu chip tích hợp nhân xử lý trí tuệ nhân tạo (AI PC) như Intel Core Ultra hay AMD Ryzen 8000 series đã tăng trưởng hơn 150% so với quý trước. Khách hàng chủ yếu là lập trình viên, nhà sáng tạo nội dung, nhân viên văn phòng và học sinh sinh viên ngành công nghệ. Việc sở hữu một chiếc máy tính có khả năng chạy AI trực tiếp giúp tăng hiệu suất làm việc nhóm, bảo mật dữ liệu cá nhân tốt hơn và sẵn sàng cho các công nghệ tương lai. Đại diện các thương hiệu lớn như ASUS, Dell, HP và Lenovo cũng khẳng định sẽ tập trung toàn bộ dải sản phẩm trung và cao cấp của họ vào phân khúc laptop AI trong năm nay để đáp ứng nhu cầu thị trường.",
                    "Các chuỗi bán lẻ công nghệ lớn tại Việt Nam ghi nhận nhu cầu mua sắm laptop trang bị vi xử lý tích hợp NPU tăng mạnh nhờ xu hướng học tập và làm việc thông minh.",
                    "VnExpress.net",
                    "https://vnexpress.net/so-hoa",
                    "https://images.unsplash.com/photo-1603302576837-37561b2e2302?w=800",
                    LocalDateTime.now().minusDays(5)
            ));

            newsArticleRepository.save(new NewsArticle(
                    "ASUS trình làng loạt laptop ROG Strix thế hệ mới trang bị cấu hình cực khủng",
                    "Thương hiệu gaming Republic of Gamers (ROG) của ASUS vừa qua đã chính thức công bố sự kiện ra mắt dải sản phẩm laptop chơi game cao cấp ROG Strix SCAR 16 và ROG Strix SCAR 18 tại thị trường Việt Nam. Được thiết kế dành riêng cho các game thủ chuyên nghiệp và những người đam mê hiệu năng đỉnh cao, thế hệ Strix SCAR năm nay trang bị bộ vi xử lý Intel Core i9-14900HX mạnh mẽ cùng tùy chọn card đồ họa lên đến NVIDIA GeForce RTX 4090 công suất TGP tối đa 175W. Hệ thống tản nhiệt ROG Intelligent Cooling được nâng cấp với công nghệ 3 quạt và keo tản nhiệt kim loại lỏng Conductonaut Extreme trên cả CPU lẫn GPU giúp máy luôn duy trì hiệu suất tối đa. Ngoài ra, màn hình ROG Nebula HDR sử dụng tấm nền Mini LED thế hệ mới có tần số quét 240Hz siêu mượt mang lại trải nghiệm hiển thị hình ảnh rực rỡ và chân thực nhất cho các tựa game AAA.",
                    "Loạt laptop chuyên game cao cấp ROG Strix SCAR 16 và SCAR 18 chính thức cập bến thị trường Việt Nam với vi xử lý Core i9 thế hệ 14 và card đồ họa RTX 4090.",
                    "Tinhte.vn",
                    "https://tinhte.vn",
                    "https://images.unsplash.com/photo-1542751371-adc38448a05e?w=800",
                    LocalDateTime.now().minusDays(7)
            ));
            System.out.println(">>> Đã khởi tạo 4 bài báo công nghệ mẫu.");
        }
    }
}
