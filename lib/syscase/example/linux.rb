# frozen_string_literal: true

class Syscase
  class Example
    # Linux
    class Linux < self
      A = Syscase::Argument

      def read
        0
      end

      def write
        1
      end

      def open
        2
      end

      def writev
        20
      end

      def execve
        59
      end

      def buf
        @buf ||= A::Alloc.new(1024)
      end

      def l
        @l ||= A::Length.new
      end

      def file
        @file ||= A::String::File.new(%(HELLO WORLD!\n))
      end

      def fd
        @fd ||= A::FileDescriptor.new(1)
      end

      def iov
        A::Vector::V64.new(%(test\n), l, %(vec\n), l)
      end

      def filename
        A::String::Filename.new('testing')
      end

      def filename_shell
        A::String::Filename.new(%(#!/bin/sh\necho hi $FOO $@!\n))
      end

      def vector1
        A::Vector::V64.new(%(prog\0), %(test\0), %(this\0), 0)
      end

      def vector2
        A::Vector::V64.new(%(FOO=bar\0), 0)
      end
    end
  end
end
