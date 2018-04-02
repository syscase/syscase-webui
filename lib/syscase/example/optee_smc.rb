# frozen_string_literal: true

# rubocop:disable Metrics/ClassLength
class Syscase
  class Example
    # OPTEE
    class OPTEESMC < self
      A = Syscase::Argument

      def std_count
        with_size(0x8400ff00)
      end

      def std_uid
        with_size(0x8400ff01)
      end

      def std_version
        with_size(0x8400ff03)
      end

      def optee_count
        with_size(0xbf00ff00)
      end

      def optee_uid
        with_size(0xbf00ff01)
      end

      def optee_revision
        with_size(0xbf00ff03)
      end

      def optee_os_uuid
        with_size(0xb2000000)
      end

      def optee_os_revision
        with_size(0xb2000001)
      end

      def optee_shm_config
        with_size(0xb2000007)
      end

      def optee_shm_l2cc_mutex
        with_size(0xb2000008)
      end

      def mutex_get_addr
        0
      end

      def mutex_set_addr
        1
      end

      def mutex_enable
        2
      end

      def mutex_disable
        3
      end

      def addr32_high
        0
      end

      def addr32_low
        0
      end

      def optee_capabilities
        with_size(0xb2000009)
      end

      def nsec_cap_uniprocessor
        1
      end

      def optee_disable_shm_cache
        with_size(0xb200000a)
      end

      def optee_enable_shm_cache
        with_size(0xb200000b)
      end

      def optee_boot_secondary
        with_size(0xb200000c)
      end

      def core_index1
        1
      end

      def addr32_entry_high
        0
      end

      def addr32_entry_low
        0
      end

      def optee_vm_created
        with_size(0xb200000d)
      end

      def optee_vm_destroyed
        with_size(0xb200000e)
      end

      def optee_return_rpc
        with_size(0x32000003)
      end

      def optee_return_rpc_alloc
        with_size(0xffff0000)
      end

      def optee_return_rpc_free
        with_size(0xffff0002)
      end

      def addr32_shm_cookie_high
        0
      end

      def addr32_shm_cookie_low
        0
      end

      def optee_return_rpc_foreign_intr
        with_size(0xffff0004)
      end

      def optee_return_rpc_cmd
        with_size(0xffff0005)
      end

      def addr32_optee_msg_arg_high
        0
      end

      def addr32_optee_msg_arg_low
        0
      end

      def optee_with_arg
        with_size(0x32000004)
      end

      def smc_shm_cached
        1
      end

      def client0
        0
      end

      def client1
        1
      end

      def buf
        @buf ||= A::Alloc.new(1024)
      end

      def with_size(number)
        { number: A::Number.new(number), size: 7 }
      end
    end
  end
end
# rubocop:enable Metrics/ClassLength
